TMPFILE="$ARG"
source "$HELPERS"

if [ -z "$TMPFILE" ]; then
  echo "No file to ins.all"
  exit 1
fi

RUNBIN="/usr/local/bin/harper-ls-${VERSION}"
PROJDIR="${workdir}/harperls"

mkdir -p "$PROJDIR"
tar -C "$PROJDIR/" -xzf "$TMPFILE"
cd "$PROJDIR"
rm /usr/local/bin/harper-ls-v* > /dev/null
mv harper-ls "$RUNBIN"
ln -sf "$RUNBIN" /usr/local/bin/harper-ls

# This script runs as sudo, so careful with the removes, but also dont leave
# anything created in here in the $WORKDIR folder
cd "$WORKDIR"
rm -rf "$PROJDIR"
