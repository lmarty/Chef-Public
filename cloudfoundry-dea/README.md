Description
===========

Install the Cloud Foundry [DEA](https://github.com/cloudfoundry/dea)
(Droplet Execution Agent), a mandatory component of a
[Cloud Foundry](http://www.cloudfoundry.org) installation.

*NOTE*: for the DEA to be useful at all, you need to also install one or more
runtimes. Currently supported runtimes are:

* [cloudfoundry-ruby-runtime](https://github.com/zephirworks/cloudfoundry-ruby-runtime)

Requirements
============

Chef
---

This cookbook is fully supported on Chef 10.x starting with 10.14.x, as well
as Chef 11.

*NOTE*: at this time the other cookbooks for runtimes are not officially
supported on Chef 11; testing is in progress. If you do try running them on
Chef 11, please make sure to file a GitHub issue for any problem you may find.

Tested on:

* Chef 10.14.4
* Chef 11.4.0

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

* `node['cloudfoundry_dea']['pid_file']` - Where to write the DEA's pid file.
Defaults to `File.join(node['cloudfoundry']['pid_dir'], "dea.pid")`.
* `node['cloudfoundry_dea']['log_file']` - Where to write the DEA's logs.
Defaults to `File.join(node['cloudfoundry']['log_dir'], "dea.log")`.
* `node['cloudfoundry_dea']['base_dir']` - TODO (trotter): Find out what is
stored here. Defaults to `/var/vcap/data/dea"`.
* `node['cloudfoundry_dea']['filter_port']` - TODO (trotter): Find out what
this does. Defaults to `12345`.
* `node['cloudfoundry_dea']['heartbeat']` - Interval (in seconds) between
heartbeats sent to the Health Manager. Defaults to `10`.
* `node['cloudfoundry_dea']['advertise']` - Interval (in seconds) for sending
advertisments of available resources. Defaults to `5`.
* `node['cloudfoundry_dea']['log_level']` - Log level for the DEA. Defaults
to `info"`.
* `node['cloudfoundry_dea']['max_memory']` - The maximum amount of memory this
DEA is allowed to allocate across all its applications. Defaults to `4096`.
* `node['cloudfoundry_dea']['secure_env']` - TODO (trotter): Find out what
this does. Defaults to `false`.
* `node['cloudfoundry_dea']['multi_tenant']` - Allow the DEA to manage more
than one application. Defaults to `true`.

Usage
=====

The default recipe will install the CloudFoundry DEA on the target node along
with the necessary configuration files and init scripts to run it. Simply add
it to your run list:

    run_list "recipe[cloudfoundry-dea]"

To also install support for ruby apps:

    run_list "recipe[cloudfoundry-dea]", "recipe[cloudfoundry-ruby-runtime]"

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
