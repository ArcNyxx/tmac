# tmac - troff macro package files
# Copyright (C) 2022 FearlessDoggo21
# see LICENCE file for licensing information

.POSIX:

include config.mk

options:
	@echo "tmac:      installs macro packages"
	@echo "man:       installs man pages"
	@echo "dist:      packages repository for distribution"
	@echo "install:   installs both macro packages and man pages"
	@echo "uninstall: uninstalls both macro pages and man pages"

tmac:
	cp la.tmac $(DESTDIR)$(TMAC_FOLDER)/la
	cp ono.tmac $(DESTDIR)$(TMAC_FOLDER)/ono
	cp hw.tmac $(DESTDIR)$(TMAC_FOLDER)/hw
	chmod 644 $(DESTDIR)$(TMAC_FOLDER)/la $(DESTDIR)$(TMAC_FOLDER)/ono \
		$(DESTDIR)$(TMAC_FOLDER)/hw

man:
	sed "s|TMAC_FOLDER|$(TMAC_FOLDER)|g" < troff_mla.7 > \
		$(DESTDIR)$(MANPREFIX)/man7/troff_mla.7
	sed "s|TMAC_FOLDER|$(TMAC_FOLDER)|g" < troff_mono.7 > \
		$(DESTDIR)$(MANPREFIX)/man7/troff_mono.7
	sed "s|TMAC_FOLDER|$(TMAC_FOLDER)|g" < troff_hw.7 > \
		$(DESTDIR)$(MANPREFIX)/man7/troff_hw.7
	chmod 644 $(DESTDIR)$(MANPREFIX)/man7/troff_mla.7 \
		$(DESTDIR)$(MANPREFIX)/man7/troff_mono.7 \
		$(DESTDIR)$(MANPREFIX)/man7/troff_hw.7

dist:
	mkdir -p tmac-$(VERSION)
	cp -R README LICENCE Makefile config.mk la.tmac ono.tmac hw.tmac \
		troff_mla.7 troff_mono.7 troff_hw.7
	tar -cf tmac-$(VERSION).tar tmac-$(VERSION)
	gzip tmac-$(VERSION).tar
	rm -rf tmac-$(VERSION)

install: tmac man

uninstall:
	rm -f $(DESTDIR)$(TMAC_FOLDER)/la.tmac $(DESTDIR)$(TMAC_FOLDER)/ono.tmac \
		$(DESTDIR)$(TMAC_FOLDER)/hw.tmac \
		$(DESTDIR)$(MANPREFIX)/man7/troff_mla.7 \
		$(DESTDIR)$(MANPREFIX)/man7/troff_mono.7 \
		$(DESTDIR)$(MANPREFIX)/man7/troff_hw.7

# implementation defined
.PHONY: all tmac man dist uninstall
