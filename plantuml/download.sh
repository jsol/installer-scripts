source "$HELPERS"
USER="plantuml"
REPO="plantuml"

EXT="jar"
TMPFILE="$WORKDIR/new-plantuml.$EXT"
GPGFILE="$WORKDIR/check.$USER.$REPO.asc"
# Fetched keyid from github user profile
KEYID=c08c18ee1706db378bd993c8019586d44bd80213

URL=`github_download_link "$USER" "$REPO" plantuml."$EXT"` 
GPGURL=`github_download_link "$USER" "$REPO" plantuml."$EXT".asc` 

if ! curl -s -L "$GPGURL" -o "$GPGFILE"; then
  echo "FAILED to download the gpg signature, stopping update. ($GPGURL -> $URL)"
  exit 1
fi

if ! curl -s -L "$URL" -o "$TMPFILE"; then
	echo "FAILED to download the file, stopping update."
  exit 1
fi

gpg_verify "$KEYID" "$GPGFILE" "$TMPFILE"

echo $TMPFILE
