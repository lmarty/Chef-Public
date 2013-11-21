Description
===========

Install the Cloud Foundry [stager](https://github.com/cloudfoundry/stager),
a mandatory component of a [Cloud Foundry](http://www.cloudfoundry.org)
installation.

Note: we recommend you deploy the `stager` on the same node as the
`cloud_controller`. While this may not be necessary, this release has only
been tested in that configuration.

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

* `node['cloudfoundry_stager']['vcap']['install_path']` - Path to a directory
that will hold the code for the stager. Defaults to `/srv/vcap-stager`.
* `node['cloudfoundry_stager']['vcap']['repo']` - Source repository for the
stager code. Defaults to `https://github.com/cloudfoundry/stager.git`.
* `node['cloudfoundry_stager']['vcap']['reference']` - Git reference to use
when fetching the stager code. Can be either a specific sha or a reference
such as `HEAD` or `master`. Defaults to the last revision that has been
tested with the `cloudfoundry` family of cookbooks.
* `node['cloudfoundry_stager']['ruby_version']` - Version of the ruby
interpreter to use to run the stager daemon. Defaults to
`node['cloudfoundry']['ruby_version']`.
* `node['cloudfoundry_stager']['log_level']` - Log level for the stager.
Defaults to `info`.
* `node['cloudfoundry_stager']['log_file']` - Path to the stager log file.
Defaults to `File.join(node['cloudfoundry']['log_dir'], "stager.log")`.
* `node['cloudfoundry_stager']['pid_file']` - Path to the stager pid file.
Defaults to `File.join(node['cloudfoundry']['pid_dir'], "stager.pid")`.
* `node['cloudfoundry_stager']['max_staging_duration']` - Maximum number
of seconds a staging can run. Defaults to `120`.
* `node['cloudfoundry_stager']['max_active_tasks']` - Maximum number of
tasks executing concurrently. Defaults to `10`.
* `node['cloudfoundry_stager']['queues']` - List of queues to pull tasks
from. Defaults to `['staging']`.
* `node['cloudfoundry_stager']['data_dir']` - Base directory for the stager
to store working information; it is used to set defaults for other attributes
(see below). Defaults to
`File.join(node['cloudfoundry']['data_dir'], "stager")`.
* `node['cloudfoundry_stager']['tmp_dir']` - Path to a directory where the
stager will create temporary files. Defaults to
`File.join(node['cloudfoundry_stager']['data_dir'], "tmp")`.
* `node['cloudfoundry_stager']['cache_dir']` - Path to a directory where the
staging plugins will cache reusable software artifacts (ruby gems, npm
packages etc). Defaults to
`File.join(node['cloudfoundry_stager']['data_dir'], "package_cache", "ruby")`.
* `node['cloudfoundry_stager']['secure']` - Set true to run the staging process
as a separate unprivileged user. WARNING: it seems to be unused at this time.
Defaults to `false`.

Usage
=====

Simply add `recipe[cloudfoundry-stager]` to the run list.
