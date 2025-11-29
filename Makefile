.POSIX:
PREFIX = ${HOME}/.local
.PHONY: install uninstall
NAME = glo
VERSION = pre-release

$(NAME):
	sed "s|@VERSION@|$(VERSION)|g" glo.sh > $@
	chmod 755 $@

install: $(NAME)
	mkdir -p ${DESTDIR}${PREFIX}/bin
	cp -vf $(NAME) ${DESTDIR}${PREFIX}/bin
uninstall:
	rm -vf ${DESTDIR}${PREFIX}/bin/$(NAME)
clean:
	rm -vrf $(NAME)

