TMPFILE=$ARG

if [ -z "$TMPFILE" ]; then
  echo "No tar file to install"
  exit 1
fi

if which apt > /dev/null; then
  apt install "$TMPFILE"
else 
  SOURCEDIR=`tar_gz_extract "$TMPFILE"`
  cd "$WORKFILE/$SOURCEDIR"
  mv zoxide /usr/local/bin
  cd "$WORKDIR"
  # This script runs as sudo, so careful with the removes, but also dont leave
  # anything created in here in the $WORKDIR folder
  rm -rf "$SOURCEDIR"
fi
