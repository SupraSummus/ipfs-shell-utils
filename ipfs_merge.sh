#!/usr/bin/env bash
set -e

# use tab as field separator
export IFS=$'\t'
export OFS=$'\t'

function ipfs_ls_mangled {
	# output is of format: name type hash
	# * decorate `ipfs ls` output with directory / file info
	# * strip trailing slash
	# * make output tab-delimited
	ipfs ls "$1" | sed -e 's/  */\t/; s/  */\t/;' |
	awk -F $'\t' 'BEGIN      {OFS="\t"}
	              $3 ~ /\/$/ {print substr($3, 1, length($3)-1), "d", $1; next}
	                         {print $3, "f", $1}'
}

function merge {
	hash="$1"

	while read name type1 hash1 type2 hash2; do
		if [ "$type2" == "" ]; then
			# object only in second tree
			echo "2 $3$name" 1>&2
			hash=$(ipfs object patch add-link "$hash" "$name" "$hash1")
		elif [ "$type1" == "d" ] && [ "$type2" == "d" ] && [ "hash1" != "hash2" ]; then
			# merge dirs
			echo "d $3$name" 1>&2
			merged_hash=$(merge "$hash1" "$hash2" "$3$name/")
			hash=$(ipfs object patch add-link "$hash" "$name" "$merged_hash")
		elif [ "$hash1" != "$hash2" ]; then
			# different objects - pick second tree version
			echo "2 $3$name" 1>&2
			hash=$(ipfs object patch add-link "$hash" "$name" "$hash2")
		fi
	done < <(join -t $'\t' -a 2 <(ipfs_ls_mangled "$1") <(ipfs_ls_mangled "$2"))

	echo "$hash"
}

merge "$1" "$2" ""
