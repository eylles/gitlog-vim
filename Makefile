.POSIX:
PREFIX = ${HOME}/.local
BIN_LOC = $(DESTDIR)${PREFIX}/bin
MANPREFIX = $(DESTDIR)$(PREFIX)/share/man/man1
.PHONY: install uninstall
NAME = glo
VERSION = 0.0.0

$(NAME):
	sed "s|@VERSION@|$(VERSION)|g" glo.sh > $@
	chmod 755 $@
	sed "s|@VERSION@|$(VERSION)|g" glo.1.in > glo.1

install: $(NAME)
	mkdir -p $(BIN_LOC)
	cp -vf $(NAME) $(BIN_LOC)/
	mkdir -p $(MANPREFIX)
	cp -vf glo.1 $(MANPREFIX)/
uninstall:
	rm -vf $(BIN_LOC)/$(NAME)
	rm -vf $(MANPREFIX)/glo.1
clean:
	rm -vrf $(NAME) glo.1

