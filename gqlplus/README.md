# gqlplus [![Build Status](https://secure.travis-ci.org/atomic-penguin/cookbook-gqlplus.png?branch=master)](http://travis-ci.org/atomic-penguin/cookbook-gqlplus)

## Description

    gqlplus is a UNIX front-end program for Oracle's command-line utility
sqlplus. gqlplus is functionally identical to sqlplus, with the
addition of command-line editing, history, table-name and optional
column-name completion.

gqlplus [homepage](http://sourceforge.net/projects/gqlplus/files/gqlplus)

## Requirements

### Cookbook dependencies

* ark
* build-essential
* ncurses
* readline

## Attributes

* gqlplus['url']
  - The tarball location on Sourceforge
  - Defaults to the gqlplus, version 1.14

* gqlplus['checksum']
  - The SHA256 checksum of the tarball specified in the `url` attribute

## Usage

Simply put `recipe[gqlplus]` in your `run_list` to build and install on
your system.

## License and Author

Author: Eric G. Wolfe

Copyright 2012, Eric G. Wolfe

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
