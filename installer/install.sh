TMPFILE="$ARG"
source "$HELPERS"

if [ -z "$TMPFILE" ]; then
  echo "No file to install"
  exit 1
fi

chmod a+x "$TMPFILE"
RUNBIN="/usr/local/bin/installer"
mv "$TMPFILE" "$RUNBIN"

