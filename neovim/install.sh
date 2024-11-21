TMPFILE=$ARG

if [ -z "$TMPFILE" ]; then
  echo "No tar file to install"
  exit 1
fi

rm -rf /opt/nvim
tar -C /opt -xzf "$TMPFILE"
