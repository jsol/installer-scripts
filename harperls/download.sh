source "$HELPERS"
USER=elijah-potter
REPO=harper
TMPFILE="$WORKDIR/new-harperls.tar.gz"

URL=`github_download_link "$USER" "$REPO" tar.gz linux x86_64`

if ! curl -s -L "$URL" -o "$TMPFILE"; then
	echo "FAILED to download the $URL, stopping update."
  exit 1
fi

echo $TMPFILE
