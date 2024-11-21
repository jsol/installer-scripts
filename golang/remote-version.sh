source "$HELPERS"

FULL_META_FILE="$WORKDIR/meta.golang.full.json"
CURRENT_META_FILE="$WORKDIR/meta.golang.current.json"

curl -s "https://go.dev/dl/?mode=json" > "$FULL_META_FILE"
jq "[.[] | select(.stable == true ) | .files[] | select(.os | contains(\"$OS\")) | select(.arch | contains(\"$ARCH\"))][0]" "$FULL_META_FILE" > "$CURRENT_META_FILE"

jq -r .version "$CURRENT_META_FILE"
