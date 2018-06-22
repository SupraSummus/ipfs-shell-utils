IPFS shell utils
================

Here are some helper commands to work with IPFS.

Install
-------

    make install PREFIX=~/.local

Commands
--------

### ipfs-ls-r

Recusively lists directory.

    ipfs-ls-r Qmd5SFEy733qzzew3zNuAyzczs3ELzLE5gt87et6pMgbFR/iso
    # QmRVozAaQK8gD3Z3Pa3vsBx34f68oBUR7g4usgnXoJtXmK	147038670	latest/
    # QmZi4rNYPLpL8DkL3M6UUqe79ZQY6agr5ofrBaHzSXC5jM	147038165	latest/archlinux-bootstrap-2017.11.01-x86_64.tar.gz
    # QmfMvRNZE9wr2dCnoobQs6mR1wdF9NkTzQFAPS5hMChFjh	321	latest/archlinux-bootstrap-2017.11.01-x86_64.tar.gz.sig

### ipfs-merge

Recursively merges two trees. Conflicts are resolved in favour for second tree.
This script requires bash.

Slightly long example:

    ipfs-ls-r QmX6HcULwFs85dYxhhsEVdf6ng6Wjqtq5d9Xxewx7LybYi
    # QmUNLLsPACCz1vLxQVkXqqLX5R1X345qqfHbsf67hvA3Nn	4	bbb/
    # QmcC7Zd4edNaxfYRG2sssnnJq9x5wSz4WZGqgPNszrEtRy	53	common/
    # QmUNLLsPACCz1vLxQVkXqqLX5R1X345qqfHbsf67hvA3Nn	4	common/txt/
    ipfs-ls-r QmQomi23vpduW6dyBGPJasU5hvbx5E7yPXmnrR6LXmBYWg
    # QmUNLLsPACCz1vLxQVkXqqLX5R1X345qqfHbsf67hvA3Nn	4	aaa/
    # QmNQxQC9mLao6rb2Q7KU9r5fQyk8xukrNFYayHxxmoKZfo	59	common/
    # QmSFxnK675wQ9Kc1uqWKyJUaNxvSc2BP5DbXCD3x93oq61	10	common/txt
    ipfs-ls-r $(ipfs-merge QmX6HcULwFs85dYxhhsEVdf6ng6Wjqtq5d9Xxewx7LybYi QmQomi23vpduW6dyBGPJasU5hvbx5E7yPXmnrR6LXmBYWg)
    # QmUNLLsPACCz1vLxQVkXqqLX5R1X345qqfHbsf67hvA3Nn	4	aaa/
    # QmUNLLsPACCz1vLxQVkXqqLX5R1X345qqfHbsf67hvA3Nn	4	bbb/
    # QmNQxQC9mLao6rb2Q7KU9r5fQyk8xukrNFYayHxxmoKZfo	59	common/
    # QmSFxnK675wQ9Kc1uqWKyJUaNxvSc2BP5DbXCD3x93oq61	10	common/txt

### ipfs-mkdir

Creates direcory with specified contents. For example to create
directory with two empty directories named `aaa` and `bbb` run:

    ipfs-mkdir aaa $(ipfs-mkdir) bbb $(ipfs-mkdir)

### ipfs-publish-swap

Streaming command that publishes paths passed to it in stdin.
Unpublished paths are sent to stdout. For example:

    ipfs-mkdir | ./ipfs_publish_swap.sh QmXBVaAJFN5FJ4Sxe2gMosL6mPgdhW3BkwbVJtXdm8tLyo 2> /dev/null
    # Qm1111SomeHashThatWasPublishedPreviously111111
    ipfs-mkdir | ./ipfs_publish_swap.sh QmXBVaAJFN5FJ4Sxe2gMosL6mPgdhW3BkwbVJtXdm8tLyo 2> /dev/null
    # stdout is empty becuse nothing was unpublished

### ipfs-orphans

Print hashes pinned but not published on local node. Takes no arguments.

    ipfs-orphans 
    # QmcSYVyDQrm2gFD2EgcYqAvSYofVkUq7EnhWkmGzKQ8nVS
    # QmSomeOtherHashaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
