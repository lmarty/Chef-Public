Description
===========

[HeidiSQL](http://www.heidisql.com/) HeidiSQL is a lightweight, Windows based application for managing MySQL and Microsoft SQL databases. This cookbook installs the HeidiSQL.

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

* `node[:heidisql][:home]` - location to install HeidiSQL files to.  default is `%SYSTEMDRIVE%\HeidiSQL`

Usage
=====

default
-------

Downloads and installs HeidiSQL to the location specified by `node[:heidisql][:home]`.

Changes/Roadmap
===============

## 0.1.0:

* initial release

## 1.0.0:

* fixed HeidiSQL package name to avoid unnecessary installations


License and Author
==================

Author:: Thorsten Klein (<cookbooks@perlwizard.de>)

Copyright:: 2013, Thorsten Klein.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
 