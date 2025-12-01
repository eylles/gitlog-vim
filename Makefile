.POSIX:
PREFIX = ${HOME}/.local
.PHONY: install uninstall
NAME = glo
VERSION = pre-release

$(NAME):
	sed "s|@VERSION@|$(VERSION)|g" glo.sh > $@
	chmod 755 $@
	sed "s|@VERSION@|$(VERSION)|g" glo.1.in > glo.1

install: $(NAME)
	mkdir -p ${DESTDIR}${PREFIX}/bin
	cp -vf $(NAME) ${DESTDIR}${PREFIX}/bin
	mkdir -p $(DESTDIR)$(PREFIX)/share/man/man1
	cp -vf glo.1 $(DESTDIR)$(PREFIX)/share/man/man1/
uninstall:
	rm -vf ${DESTDIR}${PREFIX}/bin/$(NAME)
	rm -vf $(DESTDIR)$(PREFIX)/share/man/man1/glo.1
clean:
	rm -vrf $(NAME) glo.1

