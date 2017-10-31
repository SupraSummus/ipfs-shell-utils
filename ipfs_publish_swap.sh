#!/bin/sh
set -e

for path in $(cat -); do

	old_path=$(ipfs name resolve -n -- "$1" | cut -d / -f 3)

	if [ "$old_path" != "$path" ]; then
		ipfs name publish --key "$1" -- "$path" 1>&2
		echo "$old_path"
	fi

done
