Description
===========

Installs and configures a [Nats](https://github.com/derekcollison/nats)
server for use with CloudFoundry.

This cookbook will install a Nats Server on the target node along with
the necessary configuration files and init scripts to run it. Because
Nats is used so heavily by CloudFoundry, this cookbook relies on the
`cloudfoundry` cookbook for common functionality.

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
* rbenv

Attributes
==========

* `node['nats']['gem]['version']` - Version of the nats gem to install. Default is `0.4.28`.
* `node['nats_server']['host']` - Nats will bind to this host. Default is `0.0.0.0`.
* `node['nats_server']['port']` - Nats will bind to this port. Default is `4222`.
* `node['nats_server']['user']` - Clients will connect to nats as this user. Default is `nats`.
* `node['nats_server']['password']` - Clients will connect to nats with this password. Default is `nats`.
* `node['nats_server']['pid_file']` - Where to write Nats's pid. Default is `File.join(node['cloudfoundry']['pid_dir'], "nats-server.pid")`.
* `node['nats_server']['log_file']` - Where to write Nats's logs. Default is `File.join(node['cloudfoundry']['log_dir'], "nats-server.log")`.
* `node['nats_server']['ruby_version']` - Ruby version to use to run Nats. Default is `node['cloudfoundry']['ruby_version']`; there should be no reason to change it.

Recipes
=======

default
-------

At this time the default recipe does nothing.

client
------

Installs the `nats` gem for use as a client, i.e. in order to get the CLI tools.

server
------

Installs the `nats` gem for use as a server, configures it and runs it as a daemon.

License and Author
==================

Author:: Andrea Campi (<andrea.campi@zephirworks.com>)
Author:: Trotter Cashion (<cashion@gmail.com>)

Copyright:: 2012 ZephirWorks
Copyright:: 2012 Trotter Cashion

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
