
if ! command -v go >/dev/null 2>&1
then
    exit
fi

CURRENT=$(go version | cut -d ' ' -f 3)
echo $CURRENT


