Description
===========

Installs and configures a PyPi mirror server to be used as either a public or private mirror. 

This mirror is setup as per PEP 381 (<http://www.python.org/dev/peps/pep-0381/>).

The recipe uses and is configured as per the official pep381client found at <http://pypi.python.org/pypi/pep381client>.

Requirements
============

Cookbooks
---------

The following cookbooks are direct dependencies because they are used for common "default" functionality.

* apache2
* python

Platform
--------

Tested under Ubuntu 10.04.

TODO: Test using test-kitchen

Attributes
==========

## default.rb

The following attributes are configurable for this cookbook:

* `node['pypi-mirror']['version']` - The version of pep381client to install. Defaults to 1.5.
* `node['pypi-mirror']['dir']` - Location for the PyPi Mirror files
* `node['pypi-mirror']['cgi-dir']`  - Location the sync cgi file should be created
* `node['pypi-mirror']['server_name']` - The URL used by Apache as the host header

* `node['pypi-mirror']['cron']['minute']` - Minute setting for the sync cron job 
* `node['pypi-mirror']['cron']['hour']`  - Hour setting for the sync cron job
* `node['pypi-mirror']['cron']['day']` - Day setting for the sync cron job
* `node['pypi-mirror']['cron']['month']`  - Month setting for the sync cron job
* `node['pypi-mirror']['cron']['weekday']` - Weekday setting for the sync cron job

* `node['pypi-mirror']['logs']['minute']` - Minute setting for the logs cron job
* `node['pypi-mirror']['logs']['hour']` - Hour setting for the logs cron job
* `node['pypi-mirror']['logs']['day']` - Day setting for the logs cron job
* `node['pypi-mirror']['logs']['month']` - Month setting for the logs cron job
* `node['pypi-mirror']['logs']['weekday']` - Weekday setting for the logs cron job

This recipe also uses some of the standard apache2 attributes to ensure it plays nicely with your apache settings:

* `node['apache']['user']` - The user your apache is running as, used for directory creation
* `node['apache']['group']` - The group your apache is running as, used for directory creation
* `node['apache']['log_dir']` - The base log directory used by apache, to ensure the processing of pypi logs can be done using the apache access log.

Recipes
=======

This cookbook contains one main recipe for installing PyPi Mirror:

* default.rb: Performs the work of installing the pep381client, apache and associated cron jobs


Usage
=====

Include the recipe on your node or role that fits how you wish to install PyPi Mirror on your system per the recipes section above. Modify the attributes as required in your role to change how various configuration is applied per the attributes section above. In general, override attributes in the role should be used when changing attributes.

License and Author
==================

- Author:: Kel Phillipson (<kel@kelfish.com>)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
