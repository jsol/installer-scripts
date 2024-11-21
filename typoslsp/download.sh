source "$HELPERS"
USER="tekumara"
REPO="typos-lsp"
TMPFILE="$WORKDIR/new-typoslsp.tar.gz"

URL=`github_download_link "$USER" "$REPO" tar.gz linux x86_64 gnu`

if ! curl -s -L "$URL" -o "$TMPFILE"; then
	echo "FAILED to download the $URL, stopping update."
  exit 1
fi

echo $TMPFILE
