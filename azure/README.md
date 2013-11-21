Description
===========

The Azure cookbook installs and configures the Windows Azure Linux agent for your
selected distribution and provides an OHAI plugin that populates the `azure` and 
`cloud` mashes with proper data in the same way the EC2 and Rackspace plugins do.

For RPM-based distributions, you have to provide your own URL for RPM installation.
You can build your own Linux Agent RPM using the .spec file published by Microsoft 
on https://github.com/windows-azure/walinuxagent.

Please note that the OHAI plugin currently supports in-VM only discovery of 
attributes. That means that external attributes like the VM name, Affinity Groups
and the such are not available, since they need to be discovered via API calls
to the Windows Azure endpoints.

Requirements
============

Cookbooks
---------

This cookbook depends on the `ohai` cookbook for the `azure::ohai_plugin` recipe.

Platform
--------

The following platforms are supported and tested:

* Ubuntu 12.04, 12.10
* CentOS 6

Other Debian and RHEL family distributions are assumed to work.

Chef Server
-----------

The cookbook converges best on Chef installations >= 10.16.2

Attributes
==========

The following attributes are available on this cookbook. Please use `n` for features that you
want disabled and `y` for features that you want enabled.

* `node['azure']['rpm']['url']` - By default `nil`, update it with your agent RPM URL for RPM-based
  virtual machines.
* `node['azure']['rpm']['checksum']` - The SHA-256 checksum of the above RPM.

* `node['azure']['ohai']['override_embedded']` - Installs the custom OHAI plugin and overrides the one that ships with Chef
* `node['azure']['ohai']['cleanup_old_versions']` - Removes the older custom azure.rb OHAI plugin, since that is again overriden by the
  one shipped with Chef.

* `node['azure']['agent']['provisioning']` - Enables the provisioning code of the Lnux agent.
* `node['azure']['agent']['delete_root_password']` - If provisioning is enabled, disables the root password of the system.
* `node['azure']['agent']['regenerate_ssh_key']` - Recreates the root user SSH private key in the provisioning phase.
* `node['azure']['agent']['ssh_key_type']` - Defines the SSH key type that will be regenerated.
* `node['azure']['agent']['monitor_hostname']` - Detects hostname changes on the VM and updates the service accordingly

* `node['azure']['agent']['resource_disk_format']` - If enabled, formats the local ephemeral storage attached to the VM
* `node['azure']['agent']['resource_disk_filesystem']` - The filesystem with which the local ephemeral storage will be formatted
* `node['azure']['agent']['resource_disk_mountpoint']` - The mountpoint of the local ephemeral storage device.
* `node['azure']['agent']['resource_disk_swap']` - Enable if you want to create a swap file on the ephemeral storage device
  Recommended, since the ephemeral storage device is **very** fast! You'll have to have the ephemeral storage device enabled
  if you want to use this feature.
* `node['azure']['agent']['resource_disk_swap_size']` - The swap file size (in MB).

* `node['azure']['agent']['verbose_logs']` - Enable verbose logging of the agent.

Recipes
=======

## default.rb

The default recipe installs the Windows Azure Linux agent and 
configures the `waagent.conf` file that enables various services on the virtual machine.

## ohai_plugin.rb

The OHAI plugin recipe installs a custom Azure OHAI plugin and reloads OHAI in order to
populate the `azure` and `cloud` mashes.

OHAI Plugin
===========

The `ohai_plugin` recipe includes a custom OHAI plugin that overrides the one shipped with Chef which
only supports bootstrap hints. It provides the following attributes via OHAI:

* `node['azure']['deployment_id']` - The Azure deployment ID
* `node['azure']['instance_type']` - The name of the running instance type, i.e. Extra Large
* `node['azure']['instance_code']` - The code of the running instance type, i.e. A6

* `node['azure']['public_hostname']` - The public hostname by which your VM is accessible
* `node['azure']['public_ipv4']` - The public IP by which your VM is accessible

* `node['azure']['local_hostname']` - The actual hostname you have given to your VM
* `node['azure']['local_ipv4']` - The internal IP address of the VM

* `node['azure']['location']` - The region mnemonic you VM is located in, i.e. europewest
* `node['azure']['location_pretty']` - A more pretty version of the location attribute, i.e. Europe West

* `node['azure']['resource_disk']['device']` - The Linux device name of the resource disk attached to the VM
* `node['azure']['resource_disk']['mount']` - True if you have activated the locally attached ephemeral resource disk
* `node['azure']['resource_disk']['filesystem']` - The filesystem with which the resource disk was formatted with
* `node['azure']['resource_disk']['mountpoint']` - The mountpoint of the resource disk
* `node['azure']['resource_disk']['swap']['enabled']` - True if you have activated the swap file on the local resource disk
* `node['azure']['resource_disk']['size']` - The size of the swap file on the local resource disk

It also populates standard `cloud` attributes in the same way the EC2 and 
Rackspace plugins do, such as `public_ips`, `private_ips`, `public_ipv4`,
`local_ipv4`, `public_hostname`, `local_hostname` and `provider`.

Usage
=====

Include the recipe on your node or role. Modify the
attributes as required in your role to change how various
configuration is applied per the attributes section above. In general,
override attributes in the role should be used when changing
attributes.

License and Author
==================

- Author:: Panagiotis Papadomitsos (<pj@ezgr.net>)

Copyright 2013, Panagiotis Papadomitsos

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
