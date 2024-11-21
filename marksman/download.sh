source "$HELPERS"
USER="artempyanykh"
REPO="marksman"
TMPFILE="$WORKDIR/new-marksman.bin"

URL=`github_download_link "$USER" "$REPO" "" linux x64`

if ! curl -s -L "$URL" -o "$TMPFILE"; then
	echo "FAILED to download the $URL, stopping update."
  exit 1
fi

echo $TMPFILE
