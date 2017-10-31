DESTDIR       =
PREFIX        = /usr/local
INSTALL       = /usr/bin/env install
bindir        = $(PREFIX)/bin

install: $(SCRIPTS)
	$(INSTALL) -d $(DESTDIR)$(bindir)
	$(INSTALL) -m755 ipfs_publish_swap.sh $(DESTDIR)$(bindir)/ipfs-publish-swap
	$(INSTALL) -m755 ipfs_mkdir.sh $(DESTDIR)$(bindir)/ipfs-mkdir
