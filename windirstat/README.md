Description
===========

[WinDirStat](http://windirstat.info/) WinDirStat is a disk usage statistics viewer and cleanup tool for various versions of Microsoft Windows. This cookbook installs the WinDirStat.

Requirements
============

Platform
--------

* Windows XP
* Windows Vista
* Windows Server 2003 R2
* Windows 7
* Windows Server 2008 (R1, R2)

Cookbooks
---------

* windows

Attributes
==========

* `node[:windirstat][:home]` - location to install WinDirStat files to.  default is `%SYSTEMDRIVE%\WinDirStat`

Usage
=====

default
-------

Downloads and installs WinDirStat to the location specified by `node[:windirstat][:home]`.

Changes/Roadmap
===============

## 0.1.0:

* initial release

License and Author
==================

Author:: Thorsten Klein (<cookbooks@perlwizard.de>)

Copyright:: 2013, Thorsten Klein.

This cookbook is greatly influenced (copied) from the [7-zip cookbook](https://github.com/opscode-cookbooks/7-zip)
written by Opscode

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
 