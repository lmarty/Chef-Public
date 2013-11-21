Description
===========
Manages changing settings for udev configuration. Currently only only supports configuring network device ordering at boot. This may be managed via attributes on a role or with a `udev` data bag.

Recipes
=======

net
---
Populates the `/etc/udev/rules.d/70-persistent-net.rules` with the `['udev']['net']` hash, with keys of ethernet devices (ie. 'eth0') and values of mac addresses. It attempts to read a `udev` data bag if it exists.

udev Role
=========

You may set attributes for udev configuration via a role or with a `udev` data bag. Here is an example role:

```ruby
name "udev"
description "Configure udev"
run_list(
  "recipe[udev::net]"
  )
default_attributes(
  "udev" => {
    "net" => {
      "eth0" => "00:0c:29:49:84:33",
      "eth1" => "00:0c:29:49:84:29"
    }
  })
```

udev Data Bag
=============

In order to manage the udev configuration of machines registering themselves with their Chef Server or Opscode Hosted Chef, we may use a `udev` data bag.

```
% knife data bag create udev
% knife data bag from file udev crushinator.json
```

Here is an example of the crushinator.json, the `id` is the `node.hostname`.

```json
{
    "id": "crushinator,
    "net": {
        "eth0": "00:0c:29:49:84:33",
        "eth1": "00:0c:29:49:84:29"
    }
}
```

Usage
=====

Using either a Role or a `udev` data bag, set the `['udev']['net']` hash with the eth devices in the order desired with their mac addresses. Upon reboot, the ordering will take effect. Works well with the `pxe_dust` cookbook to set the order while provisioning the operating system.

License and Author
==================

Author:: Matt Ray (<matt@opscode.com>)

Copyright 2012 Opscode, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

