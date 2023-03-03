# makedist
reusable make support for creating distribution archives. Currently supports .tar.gz, .tar.bz2, .zip, .deb and .rpm.

## Requirements / Input

### Mandatory Required Interface
- `install` must be an existing make target which supports `PREFIX` in a way that installation can be performed to `data/usr/`.
  If there is no such target or `PREFIX=data/usr/` is not accepted for that target, creation of the `data/` will fail.
- `control.Description` must be a variable with a description text that would be used in the Debian package control file.
  If there is no such variable, creation of the `control` file for `.deb` packages will fail.

### Default Required Interface
- `control.Package` defaults to `archivename`.
- `archivename` defaults to the name of the current directory.
- `control.Version` defaults to `1.0.0`.
- `control.Section` defaults to `user/hidden`.
- `control.Priority` defaults to `optional`
- `control.Architecture` defaults to `all`
- `control.Installed-Size` defaults to `$(du -cks data/ | tail -n 1 | cut -f 1)`, i.e. the size allocated for the `data/` directory after running `make PREFIX=data/usr/ install`.
- `control.Maintainer` defaults to `$(git config user.name) <$(git config user.email)>`.

## Usage
- Provide an `install` target.
- Define `control.Description`.
- Include `makedist/MakeDist.mak` in your Makefile.

Example:

~~~~
PREFIX:=/usr/local/
INCDIR:=$(PREFIX)/include/
BINDIR:=$(PREFIX)/bin/

.PHONY: install
install:
	install -d $(INCDIR) $(BINDIR)
	install -m 0644 -t $(INCDIR)/ include/*
	install -t $(BINDIR)/ bin/*

control.Description:=foo bar - Don't put your foo in my bar.
control.Version:=1.7.12
.makedist/include/makedist/MakeDist.mk:
	git clone git@github.com:christianhujer/makedist.git
-include .makedist/include/makedist/MakeDist.mk
~~~~

You can now call `make dist` to create distribution archives of your software.

# TODO / Open Items
- Support version and tagging according to SemVer
