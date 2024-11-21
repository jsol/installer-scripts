TMPFILE="$ARG"
source "$HELPERS"

if [ -z "$TMPFILE" ]; then
  echo "No file to install"
  exit 1
fi

chmod a+x "$TMPFILE"
RUNBIN="/usr/local/bin/marksman_${VERSION}"
rm /usr/local/bin/marksman_* 2> /dev/null
mv "$TMPFILE" "$RUNBIN"
ln -sf "$RUNBIN" /usr/local/bin/marksman

