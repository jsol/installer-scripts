# marksman uses dates "y-m-d" as versions
readlink -f `which marksman` | cut -d '_' -f 2 || ""
