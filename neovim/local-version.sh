
if ! command -v nvim >/dev/null 2>&1
then
    exit
fi

CURRENT=$(nvim --version | grep "NVIM " | cut -d ' ' -f 2)
echo "$CURRENT"


