#!/bin/sh
set -e

function ls_r {
	ipfs ls $1 |
	while read hash size name; do
		echo -e "$hash\t$size\t$2$name"
		if [[ "$name" =~ /$ ]]; then
			ls_r "$hash" "$2$name"
		fi
	done
}

ls_r $1 ""
