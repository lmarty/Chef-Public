Description
===========

Installs a charset.cnf file with the default
charsets for mysql

Requirements
============

* mysql cookbook

Attributes
==========

    default[:mysql_charset][:encoding]  = "utf8"
    default[:mysql_charset][:collation] = "utf8_unicode_ci"

Usage
=====

## Include the default recipe
    recipe[mysql_charset]

License and Author
==================

Author:: Geoffrey Tran (<geoffrey.tran@gmail.com>)

Copyright:: 2012, Geoffrey Tran <http://geoffreytran.com>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.


