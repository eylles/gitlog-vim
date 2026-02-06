.POSIX:
PREFIX = ${HOME}/.local
BIN_LOC = $(DESTDIR)${PREFIX}/bin
MANPREFIX = $(DESTDIR)$(PREFIX)/share/man/man1
.PHONY: install uninstall
NAME = glo

include version.mk config.mk

$(NAME):
	sed "s|@VERSION@|$(VERSION)|g" glo.sh > $@
	chmod 755 $@
	sed "s|@VERSION@|$(VERSION)|g; s|glo|$(NAME)|g" glo.1.in > $(NAME).1

install: $(NAME)
	mkdir -p $(BIN_LOC)
	cp -vf $(NAME) $(BIN_LOC)/
	mkdir -p $(MANPREFIX)
	cp -vf $(NAME).1 $(MANPREFIX)/
uninstall:
	rm -vf $(BIN_LOC)/$(NAME)
	rm -vf $(MANPREFIX)/$(NAME).1
clean:
	rm -vrf $(NAME) $(NAME).1

