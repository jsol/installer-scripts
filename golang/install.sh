TMPFILE=$ARG

if [ -z "$TMPFILE" ]; then
  echo "No tar file to install"
  exit 1
fi


rm -rf /usr/local/go
tar -C /usr/local -xzf "$TMPFILE"
