TMPFILE="$ARG"
source "$HELPERS"

if [ -z "$TMPFILE" ]; then
  echo "No tar file to install"
  exit 1
fi

tar -C "$WORKDIR/" -xzf "$TMPFILE"

# Build a bundled meson file from the python scripts
cd "$WORKDIR"
cd `ls -d meson-*/`
./packaging/create_zipapp.py --outfile meson --interpreter '/usr/bin/env python3' .
chmod a+x meson
mv meson /usr/local/bin
cd "$WORKDIR"
# This script runs as sudo, so careful with the removes, but also dont leave
# anything created in here in the $WORKDIR folder
rm -rf meson-*
