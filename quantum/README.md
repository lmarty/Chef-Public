Description
===========
This cookbook installs Openstack Quantum to provide “network connectivity as a service” between interface devices (e.g., vNICs) managed by other Openstack services (e.g., nova) as a part of an OpenStack **Folsom** deployment.  Quantum is installed from packages.

http://quantum.openstack.org

Requirements
============
 
Chef 0.10.0 or higher required (for Chef environment use).
 
Platforms
--------
 
* Ubuntu-12.04
 
Cookbooks
---------
 
The following cookbooks are dependencies:
 
* database
* mysql
* osops-utils
 
Recipes
=======
 
default
----
-includes recipe `server`
 
server
----
-registers the quantum service tenant
-installs the quantum server package
-determines and configures networking plugin provider (set in attributes)
-registers the network service
-registers the network endpoint

plugin
----
-installs the specified networking plugin from package
-configures /etc/quantum/plugins.ini
-configures the specified plugin (only supports nicira NVP at
present)
 
 
Attributes
==========
* `developer_mode` - sets well known openstack passwords

* `openstack['quantum']['services']['api']['scheme']` - sets API versioning scheme
* `openstack['quantum']['services']['api']['network']` - sets API network
* `openstack['quantum']['services']['api']['port']` - sets API server port
* `openstack['quantum']['services']['api']['path']` - sets API version path

* `quantum['service_tenant_name']` - sets Keystone registry service tenant name for quantum
* `quantum['service_user']` - sets Keystone registry user name for quantum
* `quantum['service_role']` - sets Keystone registry service role name for quantum

* `openstack['quantum']['syslog']['use']` - controls use of syslog for quantum
* `openstack['quantum']['syslog']['facility']` - controls syslog facility setting
* `openstack['quantum']['plugin']` - sets desired plugin for use with quantum (only supports "nicira" at present)

* `openstack['quantum']['plugin']['nvp']['tz_uuid']` - sets uuid of transport zone for use with nicira nvp plugin


Templates
=====
 
* `quantum.conf.erb` - the quantum server config file
* `api-paste.ini.erb` - the paste deploy config file
* `plugins.ini.erb` - the quantum plugins config file
* `plugins/nvp.ini.erb` - the nvp plugin config file
 
 
License and Author
==================
 
Author:: George Miranda (<gmiranda@opscode.com>)
Author:: Jeremy Hanmer (<jeremy@dreamhost.com>)

Copyright 2013, Opscode, Inc.
Copyright 2012, DreamHost

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at
 
    http://www.apache.org/licenses/LICENSE-2.0
 
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
