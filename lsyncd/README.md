# chef-lsyncd [![Build Status](https://secure.travis-ci.org/bflad/chef-lsyncd.png?branch=master)](http://travis-ci.org/bflad/chef-lsyncd)

## Description

Installs/configures [lsyncd](https://github.com/axkibe/lsyncd).

## Requirements

### Platforms

* RedHat 6.3 (Santiago)

### Cookbooks

* yum

## Attributes

* `node["lsyncd"]["logfile"]` - log file for lsyncd, defaults to
  "/var/log/lsyncd.log"
* `node["lsyncd"]["statusFile"]` - status file for lsyncd, defaults to
  "/var/log/lsyncd-status.log"
* `node["lsyncd"]["statusInterval"]` - minimum seconds before updating status
  file, defaults to 20
* `node["lsyncd"]["sync"]` - Array of sync configurations, defaults to [],
  examples in Usage section

## Recipes

* `recipe[lsyncd]` will install/configure lsyncd.
* `recipe[lsyncd::source]` will install lsyncd from source.

## Usage

### Package installation and configuration

* Add sync configurations via `node["lsyncd"]["sync"]` attribute
* Add `recipe[lsyncd]` to your node's run list

### Source installation

* Add `recipe[lsyncd::source]` to your node's run list

### Sync configuration

Select a mode for the sync for further attributes.

Attributes for all modes:
* `mode` - "rsync" or "rsyncssh" - defaults to "rsync"
* `source` - _required_ - path to source directory - no default
* `exclude` - array of file exclusion strings - no default
* `excludeFrom` - path to exclude file - no default

#### rsync mode

For remote targets, normal rsync behavior of rsync all changes over the wire.

Attributes:
* `host` - remote host, used in conjunction with `targetdir` - no default
* `rsyncOpts` - array of rsync option strings, lsyncd defaults this to "-lts"
* `target` - full specification for destination ([host::]/target/dir) - no
  default
* `targetdir` - target directory, possibly used in conjunction with `host` -
  no default

Example:

    "sync" => [
      {
        "mode" => "rsync",
        "source" => "/my/source/dir",
        "target" => "remotehost::/my/target/dir"
      }
    ]

#### rsyncssh mode

Causes moves and copies to be executed on the remote host via SSH, rather than
retransmitting files over the wire. Normal rsync behavior otherwise.

Attributes:
* `host` - _required_ - remote host - no default
* `rsyncOpts` - array of rsync option strings, lsyncd defaults this to "-lts"
* `targetdir` - _required_ - target directory - no default

Example:

    "sync" => [
      {
        "mode" => "rsyncssh",
        "source" => "/my/source/dir",
        "host" => "remotehost",
        "targetdir" => "/my/target/dir"
      }
    ]

## License and Author
      
Author:: Brian Flad (<bflad@wharton.upenn.edu>)

Copyright:: 2012

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
