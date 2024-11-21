TMPFILE="$ARG"
source "$HELPERS"

if [ -z "$TMPFILE" ]; then
  echo "No zip file to install"
  exit 1
fi

RUNBIN="/usr/local/bin/mesonlsp-${VERSION}"

# Build a bundled meson file from the python scripts
cd "$WORKDIR"
mkdir "mesonlsp"
cd "mesonlsp"
unzip "$TMPFILE"
rm /usr/local/bin/mesonlsp-v*
mv mesonlsp "$RUNBIN"
ln -sf "$RUNBIN" /usr/local/bin/mesonlsp

# This script runs as sudo, so careful with the removes, but also dont leave
# anything created in here in the $WORKDIR folder
cd "$WORKDIR"
rm -rf "mesonlsp"
