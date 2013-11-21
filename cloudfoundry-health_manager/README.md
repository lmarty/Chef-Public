Description
===========

Install the Cloud Foundry [health_manager](https://github.com/cloudfoundry/health_manager),
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
* rbenv

Usage
=====

This cookbook will install the CloudFoundry Health Manager on the target
node along with the necessary configuration files and init scripts to
run it.

Attributes
==========

* `node['cloudfoundry_health_manager']['install_path']` - Path to a
directory that will hold the health_manager code. Defaults to
`/srv/cloudfoundry/health_manager`.
* `node['cloudfoundry_health_manager']['repo']` - Source repository
for the health_manager code. Defaults to
`https://github.com/cloudfoundry/health_manager.git`.
* `node['cloudfoundry_health_manager']['reference']` - Git reference to
use when fetching the health_manager code. Can be either a specific sha or
a reference such as `HEAD` or `master`. Defaults to the latest version that
was fully tested.
* `node['cloudfoundry_health_manager']['log_level']` - The health_manager
log level. Defaults to `info"`.
* `node['cloudfoundry_health_manager']['log_file']` - Where to write the
health_manager logs. Defaults to
`File.join(node['cloudfoundry']['log_dir'], "health_manager.log")`.
* `node['cloudfoundry_health_manager']['pid_file']` - Where to write the
health_manager pid file. Defaults to
`File.join(node['cloudfoundry']['pid_dir'], "health_manager.pid")`.

You may also tune a few settings that control internal parameters of the
algorithm. This is only recommended if you understand what you are doing.
See the [health_manager README](https://github.com/cloudfoundry/health_manager/blob/master/README.md)
for more information:

* `node['cloudfoundry_health_manager']['interval']['expected_state_update']` -
How often (in seconds) should the health_manager refresh its snapshot of the
"expected state" of the system. Defaults to `60`.
* `node['cloudfoundry_health_manager']['interval']['droplet_lost']` - Time
limit (in seconds) between heartbeats; if information on a droplet is not
received, the droplet will be marked as `missing`. Defaults to `30`.
* `node['cloudfoundry_health_manager']['interval']['droplets_analysis']` -
How often (in seconds) to run a complete ananlysis of all the running
droplets. Defaults to `20`.
* `node['cloudfoundry_health_manager']['interval']['flapping_death']` - Limit
number of crashes before marking an app as `flapping`. Defaults to `1`.
* `node['cloudfoundry_health_manager']['interval']['flapping_timeout']` - Time
limit (in seconds) between consecutive crashes for the purpose of flap
detection. Defaults to `180`.
* `node['cloudfoundry_health_manager']['interval']['restart_timeout']` - TODO:
Find out what this does. Defaults to `20`.
* `node['cloudfoundry_health_manager']['interval']['min_restart_delay']` -
Minimum wait (in seconds) before restarting a flapping instance. Defaults to `60`.
* `node['cloudfoundry_health_manager']['interval']['max_restart_delay']` -
Maximum wait (in seconds) before restarting a flapping instance. Defaults to `480`.
* `node['cloudfoundry_health_manager']['interval']['giveup_crash_number']` -
Maximum number of restarts for a flapping instance before giving up and
stopping it. Defaults to `4`.
* `node['cloudfoundry_health_manager']['interval']['stable_state']` - TODO:
Find out what this does. Defaults to `20`.

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
