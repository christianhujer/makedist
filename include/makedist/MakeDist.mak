ifeq (,$(MAKEDIST/MAKEDIST.MAK))
MAKEDIST/MAKEDIST.MAK:=$(lastword $(MAKEFILE_LIST))

USERNAME?=$(shell git config user.name)
EMAIL?=$(shell git config user.email)

archivename?=$(shell basename `pwd`)

# File to include from your Makefile like this:
# -include makedist/MakeDist.mak

.PHONY: dist
## Creates the distribution archives.
dist: dist/$(archivename).tar.gz dist/$(archivename).tar.bz2 dist/$(archivename).zip dist/$(archivename).deb

dist/%.tar.gz: dist/%.tar

dist/%.tar.bz2: dist/%.tar

%.gz: %
	<$< gzip -9 >$@

%.bz2: %
	<$< bzip2 -9 >$@

dist/$(archivename).tar dist/$(archivename).zip:
	mkdir -p dist
	git archive -o $@ --prefix $(archivename)/ HEAD .

.PHONY: clean
clean: cleanDist

cleanDist:
	$(RM) -r dist control data/ data.tar.gz control.gar.gz debian-binary


# TODO More variables.
control: data/
	echo "Package: $(archivename)\nVersion: 1.0.0\nSection: user/hidden\nPriority: optional\nArchitecture: all\nInstalled-Size: `du -cks data/ | tail -n 1 | cut -f 1`\nMaintainer: $(USERNAME) <$(EMAIL)>\nDescription: makedist - Reusable make support for creating distribution archives." >$@

control.tar.gz: control
	tar czf $@ $^

data.tar.gz: | data/
	tar czf $@ --transform 's.^\./,/,' -C $< .

data/:
	$(MAKE) PREFIX=data/usr/ install

debian-binary:
	echo 2.0 >$@

dist/makehelp.deb: debian-binary control.tar.gz data.tar.gz
	ar -Drc $@ $^

endif
