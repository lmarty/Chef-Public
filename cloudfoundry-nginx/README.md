Description
===========

Install a customized version of nginx for use as a router in a
[Cloud Foundry](http://www.cloudfoundry.org) installation.

Requirements
============

Platform
--------

* Ubuntu

Tested on:

* Ubuntu 10.04
* Ubuntu 12.04

Cookbooks
---------

* cloudfoundry
* nginx

Attributes
==========

* `node['cloudfoundry_nginx']['user']` - The user under which the nginx daemon
will run. Defaults to `node['cloudfoundry']['user']`.

Advanced
--------

Advanced tuning attributes; change only if necessary.

* `node['cloudfoundry_nginx']['variables_hash_max_size']` - The size of the
hash table nginx uses to store variables. Defaults to `1024`.

Usage
=====

This cookbook is used internally by other cookbooks that require nginx.

License and Author
==================

Author:: Andrea Campi (<andrea.campi@zephirworks.com>)

Copyright:: 2012, Opscode, Inc

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
