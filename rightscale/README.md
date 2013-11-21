RightScale Cookbook
===================

This cookbooks provides configuration management for nodes run on Rightscale.

## Requirements

### Chef

* Chef: 0.10.10+

### RightScale

Most of the recipes need to be run on a RightScale-managed cloud instance aka RightScale Server. You may find some recipes useful for other environments.

### Cookbooks

Depends on the following coookbooks

* collectd (for RightScale Monitoring)
* rest_connection (yet to be used)

See the `metadata.rb` file for the latest dependencies.

## Platforms

The following platforms and versions are tested.

* Debian 7, 6
* Ubuntu 12.04, 10.04

The following platform families are supported in the code, and are
assumed to work based on the successful testing on Ubuntu and CentOS.

* CentOS 6, 5
* EL/RHEL 6, 5
* Fedora

## Attributes

TODO

## Recipes

### default

Includes the following recipes as a base (recommended) state for RightScale-managed nodes:

* enforce_path_sanity
* add_sandbox_to_path (disabled by default)
* connect
* server_tags
* monitoring
* tools

### add_sandbox_to_path

Adds the RightLink sandbox to PATH in the Chef run.

### add_tags

Adds an array of RightScale tags by node attribute.

### connect

Connects the node to RightScale via token (applicable only to Blue Skies)

### enforce_path_sanity

Earlier versions of RightLink (< 5.9) do not employ 'path sanity'. This recipe adds common binary locations to PATH that some cookbooks will use.

### install_rightlink

Installs RightScale RightLink (applicable only to nodes that run another Chef).

### list_tags

Lists the current RightScale tags set on the instance.

### monitoring

Sets-up RightScale Monitoring with collectd and the server's allocated Sketchy host.

### remove_tags

Removes an array of RightScale tags by node attribute.

### server_tags

Adds recommended core RightScale tags to the server.

### standardize_chef_version

Patches the RightLink version of Chef to comply to GNU versioning scheme.

### tools

Installs RightScale Tools (awaiting gem release before can be possible).

## License and Authors

* Author:: Chris Fordham <chris [at] fordham [hyphon] nagy [dot] id [dot] au>

* Copyright:: 2012-2013, Chris Fordham

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
