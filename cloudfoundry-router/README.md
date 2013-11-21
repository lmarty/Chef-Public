Description
===========

Install the Cloud Foundry [router](https://github.com/cloudfoundry/router),
a mandatory component of a [Cloud Foundry](http://www.cloudfoundry.org)
installation.

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
* cloudfoundry-nginx
* rbenv

Usage
=====

This recipe will install a CloudFoundry Router on the target node along
with the necessary configuration files and init scripts to run it. In
addition, it will install and configure an nginx server that sits in
front of the Router. To use in your recipes:

    include_recipe "cloudfoundry-router"

Attributes
==========

* `node['cloudfoundry_router']['vcap']['install_path']` - Path to a directory
that will hold the code for the router. Defaults to `/srv/vcap-router`.
* `node['cloudfoundry_router']['vcap']['repo']` - Source repository for the
router code. Defaults to `https://github.com/cloudfoundry/router.git`.
* `node['cloudfoundry_router']['vcap']['reference']` - Git reference to use
when fetching the router code. Can be either a specific sha or a reference
such as `HEAD` or `master`. Defaults to the last revision that has been
tested with the `cloudfoundry` family of cookbooks.
* `node['cloudfoundry_router']['ruby_version']` - Version of the ruby
interpreter to use to run the stager daemon. Defaults to
`node['cloudfoundry']['ruby_version']`.
* `node['cloudfoundry_router']['listen_ip']` - IP address of the interface
that nginx will bind to. Defaults to `0.0.0.0`.
* `node['cloudfoundry_router']['listen_port']` - TCP port that nginx
will bind to. Defaults to `80`.
* `node['cloudfoundry_router']['socket_file']` - Unix socket for the
connection between the router and nginx. Defaults to `/tmp/router.sock"`.
* `node['cloudfoundry_router']['access_log']` - Where to write the router's
access log. Defaults to `File.join(node['cloudfoundry']['log_dir'], "vcap.access.log")`.
* `node['cloudfoundry_router']['client_max_body_size']` - The maximum
accepted body size of a client request. Default is `256M`.
* `node['cloudfoundry_router']['trace_key']` - Shared secret to use for
tracing requests through the router. Default is `222`.
* `node['cloudfoundry_router']['log_level']` - Log level for the router.
Defaults to `info"`.
* `node['cloudfoundry_router']['log_file']` - Where to write the router's
logs. Defaults to `File.join(node['cloudfoundry']['log_dir'], "router.log")`.
* `node['cloudfoundry_router']['pid_file']` - Where to write the router's
pid file. Default is `File.join(node['cloudfoundry']['pid_dir'], "router.pid")`.

License and Author
==================

* Author:: Andrea Campi (<andrea.campi@zephirworks.com>)
* Author:: Trotter Cashion (<cashion@gmail.com>)

* Copyright:: 2012-2013 ZephirWorks
* Copyright:: 2012 Trotter Cashion

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
