source "$HELPERS"

TMPFILE="$WORKDIR/new-golang.tar.gz"
SHATMPFILE="$WORKDIR/new-golang.tar.gz.sha256"
CURRENT_META_FILE="$WORKDIR/meta.golang.current.json"

if [ -z "$VERSION" ]; then
  echo "Could not read golang version."
  exit 1
fi

if [ -z "$OS" ]; then
  echo "Could not read golang os."
  exit 1
fi
if [ -z "$ARCH" ]; then
  echo "Could not read golang arch."
  exit 1
fi

FILENAME=$(jq -r '.filename' "$CURRENT_META_FILE")
SHA256=$(jq -r '.sha256' "$CURRENT_META_FILE")

echo "${SHA256}  $TMPFILE" > $SHATMPFILE

if ! curl -L "https://golang.org/dl/${FILENAME}" -o "$TMPFILE"; then
	echo "FAILED to download the file, stopping update."
  exit 1
fi

if ! shasum -a 256 -c "$SHATMPFILE" > /dev/null; then
	echo "FAILED to match checksums, stopping update."
  exit 1
fi

echo $TMPFILE
