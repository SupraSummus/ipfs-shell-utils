IPFS shell utils
================

Here are some helper commands to work with IPFS.

Install
-------

    make install PREFIX=~/.local

Commands
--------

### ipfs-mkdir

Creates direcory with specified contents. For example to create
directory with two empty directories named `aaa` and `bbb` run:

    ipfs-mkdir aaa `ipfs-mkdir` bbb `ipfs-mkdir`

### ipfs-publish-swap

Streaming command that publishes paths passed to it in stdin.
Unpublished paths are sent to stdout. For example:

    ipfs-mkdir | ./ipfs_publish_swap.sh QmXBVaAJFN5FJ4Sxe2gMosL6mPgdhW3BkwbVJtXdm8tLyo 2> /dev/null
    # Qm1111SomeHashThatWasPublishedPreviously111111
    ipfs-mkdir | ./ipfs_publish_swap.sh QmXBVaAJFN5FJ4Sxe2gMosL6mPgdhW3BkwbVJtXdm8tLyo 2> /dev/null
    # stdout is empty becuse nothing was unpublished
