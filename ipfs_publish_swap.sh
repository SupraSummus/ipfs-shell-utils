#!/usr/bin/env bash
set -e

KEY=${@: -1}
PARAMS=${@: 1:$#-1}

for path in $(cat -); do

	old_path=$(ipfs name resolve -n -- "$KEY" | cut -d / -f 3)
	ipfs name publish $PARAMS --key "$KEY" -- "$path" 1>&2

	if [ "$old_path" != "$path" ]; then
		echo "$old_path"
	fi

done
