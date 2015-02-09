## Installation prefix.
PREFIX:=/usr/local/

control.Description:=makedist - Reusable make support for creating distribution archives.

## Installation directory for include files.
INCDIR=$(PREFIX)/include/

.PHONY: install
## Installs makedist on your system.
install:
	install -d $(INCDIR)/makedist/
	install -m 0644 -t $(INCDIR)/makedist/ include/makedist/*

.PHONY: uninstall
## Removes makedist from your system.
uninstall:
	$(RM) -r $(INCDIR)/makedist/

include include/makedist/MakeDist.mak
-include makehelp/Help.mak
