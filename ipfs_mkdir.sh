#!/bin/sh
set -e

dir=$(ipfs object new unixfs-dir)

while test ${#} -gt 0; do
	dir=$(ipfs object patch add-link "$dir" "$1" "$2")
	shift 2
done

echo $dir
