TMPFILE="$ARG"
source "$HELPERS"

if [ -z "$TMPFILE" ]; then
  echo "No file to install"
  exit 1
fi

RUNBIN="/usr/local/bin/typos-lsp-${VERSION}"
PROJDIR="${workdir}/typoslsp"

mkdir -p "$PROJDIR"
tar -C "$PROJDIR/" -xzf "$TMPFILE"
cd "$PROJDIR"
rm /usr/local/bin/typos-lsp-v* 2> /dev/null
mv typos-lsp "$RUNBIN"
ln -sf "$RUNBIN" /usr/local/bin/typos-lsp

# This script runs as sudo, so careful with the removes, but also dont leave
# anything created in here in the $WORKDIR folder
cd "$WORKDIR"
rm -rf "$PROJDIR"
