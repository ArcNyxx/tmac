# tmac - troff macro package files
# Copyright (C) 2022 FearlessDoggo21
# see LICENCE file for licensing information

.POSIX:

include config.mk

TMAC = la.tmac ono.tmac hw.tmac
MAN = troff_mla.7 troff_mono.7 troff_hw.7

clean:
	rm -f tmac-$(VERSION).tar.gz

dist: clean
	mkdir -p tmac-$(VERSION)
	cp -R README LICENCE Makefile config.mk $(TMAC) $(MAN)
	tar -cf tmac-$(VERSION).tar tmac-$(VERSION)
	gzip tmac-$(VERSION).tar
	rm -rf tmac-$(VERSION)

install:
	for PACK in $(TMAC); do \
		BASE="$$(echo "$$PACK" | rev | cut -d. -f2- | rev)"; \
		cp "$$PACK" "$(DESTDIR)$(TMACPREFIX)/$$BASE"; \
		chmod 644 "$(DESTDIR)$(TMACPREFIX)/$$BASE"; \
	done
	for PAGE in $(MAN); do \
		sed "s|TMACPREFIX|$(TMACPREFIX)|g" < "$$PAGE" > \
			"$(DESTDIR)$(MANPREFIX)/man7/$$PAGE"; \
		chmod 644 "$(DESTDIR)$(MANPREFIX)/man7/$$PAGE"; \
	done

uninstall:
	for PACK in $(TMAC); do \
		rm -f "$(DESTDIR)$(TMACPREFIX)/$$PACK"; \
	done
	for PAGE in $(MAN); do \
		rm -f "$(DESTDIR)$(MANPREFIX)/man7/$$PAGE"; \
	done

.PHONY: clean dist install uninstall
