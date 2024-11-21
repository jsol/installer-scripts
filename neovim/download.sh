source "$HELPERS"
TMPFILE="$WORKDIR/new-neovim.tar.gz"
SHATMPFILE="$WORKDIR/new-neovim.tar.gz.sha256"

URL=`github_download_link neovim neovim tar.gz linux` 
SHAURL=`github_download_link neovim neovim tar.gz.shasum256 linux` 
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
