source "$HELPERS"
USER="BurntSushi"
REPO="ripgrep"

if which apt > /dev/null && [ "$ARCH" == "amd64" ]; then 
  EXT="deb"
  # apt don't need filtering for arch / os for downloads
  URL=`github_download_link "$USER" "$REPO" "$EXT"` 
  SHAURL=`github_download_link "$USER" "$REPO" "$EXT".sha256` 
else
  EXT="tar.gz"
  URL=`github_download_link "$USER" "$REPO" "$EXT" "$OS" "$ARCH"` 
  SHAURL=`github_download_link "$USER" "$REPO" "$EXT".sha256 "$OS" "$ARCH"` 
fi

TMPFILE="$WORKDIR/new-ripgrep.$EXT"
SHATMPFILE="$WORKDIR/new-ripgrep.$EXT.sha256"

SHA256=$(curl -s -L "$SHAURL" | cut -d " " -f 1)

echo "${SHA256}  $TMPFILE" > $SHATMPFILE

if ! curl -s -L "$URL" -o "$TMPFILE"; then
	echo "FAILED to download the file, stopping update."
  exit 1
fi

if ! shasum -a 256 -c "$SHATMPFILE" > /dev/null; then
	echo "FAILED to match checksums, stopping update."
  exit 1
fi

echo $TMPFILE
