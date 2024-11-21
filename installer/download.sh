source "$HELPERS"
USER="jsol"
REPO="installer"
TMPFILE="$WORKDIR/new-installer.bin"

URL=`github_download_link "$USER" "$REPO" "" linux amd64`

if ! curl -s -L "$URL" -o "$TMPFILE"; then
	echo "FAILED to download the $URL, stopping update."
  exit 1
fi

echo $TMPFILE
