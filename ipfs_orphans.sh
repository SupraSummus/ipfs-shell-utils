#/bin/sh
set -e

comm -1 -3 <(
	ipfs key list -l | \
	cut -d ' ' -f 1 | \
	xargs -n 1 ipfs name resolve | \
	sed -e 's/^\/ipfs\///' | \
	sort
) <(
	ipfs pin ls -t recursive | \
	cut -d ' ' -f 1 | \
	sort
)
