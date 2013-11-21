## v0.2.2
* Update passenger build to account for updated module path

## v0.2.0
* Allow packages to be built in isolation
* Tailor support towards `repository` cookbook support (reprepro support still remains)
* Fixes ruby version fetching by building proper url via version
* Support packaging multiple versions of ruby that are non-conflicting on install
* Update gem based packages to build against requested ruby version
* Fix ruby postinst script to update priority based on version and use proper version path
* Add support for attribute based meta package descriptions

## v0.1.9
* Update `DAEMON` path in redis-server init file

## v0.1.8
* Use discovery for repo searching
* Remove gem reference in add_repo

## v0.1.7
* Add not_if to direct ruby package install resource

## v0.1.6
* Update attribute usage within passenger recipe
* Add redis builder
* Initial test additions

## v0.1.5
* Update passenger versioning usage and ruby naming dependency (Thanks [Warren Bain](https://github.com/thoughtcroft))
* Add simple helper script for easily removing packages

## v0.1.4
* Use custom service resource to restart apache2 when killing run
* Update sphinx build commands to install to packaging directory via configure

## v0.1.3
* Restart apache2 before killing the run

## v0.1.2
* Allow ruby version suffix to be optional on package name

## v0.1.1
* Update ruby build naming

## v0.1.0
* Initial release
