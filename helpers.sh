#!/bin/bash
export WORKDIR="/tmp/installer"

github_ensure_file(){
  user="$1"
  repo="$2"

  if [ ! -f "/tmp/installer/meta.${user}.${repo}.json" ]; then
    TOKEN=`gh auth token`
    if [[ "$TOKEN" == gh* ]]; then
      curl -s -L -H "Accept: application/vnd.github+json" -H "Authorization: Bearer $TOKEN" -H "X-GitHub-Api-Version: 2022-11-28" \
        "https://api.github.com/repos/$user/$repo/releases/latest" > "$WORKDIR/meta.${user}.${repo}.json"
    else
      curl -L -H "Accept: application/vnd.github+json" -H "X-GitHub-Api-Version: 2022-11-28" "https://api.github.com/repos/$user/$repo/releases/latest" > "$WORKDIR/meta.${user}.${repo}.json"
    fi
  fi

  if ! jq -e . >/dev/null "$WORKDIR/meta.${user}.${repo}.json"; then
    echo "Rate limit exceeded (probabl)"
    return 1
  fi
}

github_version(){
  user="$1"
  repo="$2"

  github_ensure_file "$user" "$repo"

  jq -r .tag_name "$WORKDIR/meta.${user}.${repo}.json" 
}

github_download_link(){
  user=$1
  repo="$2"
  ext="$3"
  f1="$4"
  f2="$5"
  f3="$6"

  github_ensure_file "$user" "$repo"

  if [ -z "$f1" ]; then
    jq -r ".assets | .[] | select(.name | endswith(\"$ext\")) | .browser_download_url" "$WORKDIR/meta.${user}.${repo}.json" 
    return 0
  fi

  if [ -z "$f2" ]; then
    jq -r ".assets | .[] | select(.name | endswith(\"$ext\")) | select(.name | contains(\"$f1\")) | .browser_download_url" "$WORKDIR/meta.${user}.${repo}.json" 
    return 0
  fi
  
  if [ -z "$f3" ]; then 
    jq -r ".assets | .[] | select(.name | endswith(\"$ext\")) | select(.name | contains(\"$f1\")) | select(.name | contains(\"$f2\")) | .browser_download_url" "$WORKDIR/meta.${user}.${repo}.json" 
    return 0
  fi

  jq -r ".assets | .[] | select(.name | endswith(\"$ext\")) | select(.name | contains(\"$f1\")) | select(.name | contains(\"$f2\")) | select(.name | contains(\"$f3\")) | .browser_download_url" "$WORKDIR/meta.${user}.${repo}.json" 
}

# Verify an .asc signature, given the key id
gpg_verify(){
  keyid="$1"
  asc="$2"
  target="$3"

  if ! gpg --list-key "$keyid" > /dev/null; then 
    gpg --keyserver hkps://keyserver.ubuntu.com --recv-keys "$keyid"
  fi

  if ! gpg --verify "$asc" "$target" > /dev/null; then
    echo "Bad gpg signature for $target"
    exit 1
  fi
}

tar_gz_extract(){
  file="$1"

  tar -C "$WORKDIR" -xzf "$TMPFILE"
  SOURCEDIR=`tar --list -f "$TMPFILE" | head -n1`
  if [ -z "$SOURCEDIR" ]; then
    echo "Tar file had unexpected structure, exiting"
    exit 1
  fi

  echo "$SOURCEDIR"
}

dep_check(){
  invalid=""
  for cmd in "$@"; do
    if which "$cmd" > /dev/null; then
      echo "$cmd ok"
    else
      invalid="$cmd $invalid"
    fi
  done
  if ! [ -z "$invalid" ]; then
    echo "Install missing dependencies: $invalid"
    exit 1;
  fi
}
