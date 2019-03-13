#!/usr/bin/env bash
set -euo pipefail

comm -1 -3 <(
	ipfs key list -l | \
	cut -d ' ' -f 1 | \
	xargs -n 1 sh -c 'ipfs name resolve $0 || exit 255' | \
	sed -e 's/^\/ipfs\///' | \
	sort
) <(
	ipfs pin ls -t recursive | \
	cut -d ' ' -f 1 | \
	sort
)
