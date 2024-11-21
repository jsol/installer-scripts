source "$HELPERS"
USER="ajeetdsouza"
REPO="zoxide"

if which apt > /dev/null; then 
  EXT="deb"
  # apt don't need filtering for arch / os for downloads
  URL=`github_download_link "$USER" "$REPO" "$EXT" "$ARCH"` 
else
  EXT="tar.gz"
  URL=`github_download_link "$USER" "$REPO" "$EXT" "$OS" "$ARCH"` 
fi

TMPFILE="$WORKDIR/new-$REPO.$EXT"

if ! curl -s -L "$URL" -o "$TMPFILE"; then
	echo "FAILED to download $URL, stopping update."
  exit 1
fi

echo $TMPFILE
