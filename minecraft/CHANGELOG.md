# Changelog

## 0.4 (September 30, 2013)

> **Breaking Changes** There has been a lot of changes in this release, make sure you read everything carefully.

* Big rewrite of the Readme
* Split recipes up
* Properties are split into a seperate attribute file
* Added a minecraft group attribute
* Removed ipv6 attribute, it was never used
* new init\_style attribute defaults to mark2. It can be set to runit to get the old behavior.
* java-options attribute to specify additional runtime options when using runit only
* New cookbook dependencies on python and sudo.
* Better test coverage

Features:
  * [@webframp](https://github.com/webframp) [PR #17] Mark2 support. New recipe, attributes and template. Fixes #14
  * [@webframp](https://github.com/webframp) [PR #16] Specify version via attributes and allow upgrading

Workaround:
  * Work around #11 by adding a autorestart attribute, defaults to true.

## 0.3 (June 06, 2013)

Features:
  * Changed the default settings to work with 1GB by default
  * Integration tests with test-kitchen

Bugfixes:
  * [@benjaminws](https://github.com/benjaminws) [PR #3] Refactor minecraft.properties template
  * [@benjaminws](https://github.com/benjaminws) [PR #2] Fix template output

## 0.2 (Nov 18, 2012)

* Initial public release
