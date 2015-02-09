# makedist
reusable make support for creating distribution archives. Currently supports .tar.gz, .tar.bz2, .zip and .deb.

## Requirements / Input
- `install` must be an existing make target which supports `PREFIX` in a way that installation can be performed to `data/usr/`.
- `git config` must know `user.name` and `user.email`. Alternatively, set `USERNAME` and `EMAIL` environment.
- The current directory name is the archive basename. Alternatively, set `archivename` to the desired name.

# TODO / Open Items
- Support version and tagging according to SemVer
