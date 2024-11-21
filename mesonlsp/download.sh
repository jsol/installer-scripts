source "$HELPERS"
USER=JCWasmx86
REPO=mesonlsp
TMPFILE="$WORKDIR/new-mesonlsp.zip"

URL=`github_download_link "$USER" "$REPO" zip linux mesonlsp x86_64`

if ! curl -s -L "$URL" -o "$TMPFILE"; then
	echo "FAILED to download the $URL, stopping update."
  exit 1
fi

echo $TMPFILE
