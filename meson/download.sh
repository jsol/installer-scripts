source "$HELPERS"
USER=mesonbuild
REPO=meson
TMPFILE="$WORKDIR/new-meson.tar.gz"
GPGFILE="$WORKDIR/check.$USER.$REPO.asc"
# Fetched keyid from github user profile
KEYID=19E2D6D9B46D8DAA6288F877C24E631BABB1FE70

URL=`github_download_link "$USER" "$REPO" tar.gz` 
GPGURL=`github_download_link "$USER" "$REPO" asc` 

if ! curl -s -L "$GPGURL" -o "$GPGFILE"; then
  echo "FAILED to download the gpg signature, stopping update. ($GPGURL -> $URL)"
  exit 1
fi

if ! curl -s -L "$URL" -o "$TMPFILE"; then
	echo "FAILED to download the file, stopping update."
  exit 1
fi

gpg_verify "$KEYID" "$GPGFILE" "$TMPFILE"

echo $TMPFILE
