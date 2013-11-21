Description
===========

A little Chef recipe to convert "Self Supported" Enterprise Linux
machines to the equivalent Community Enterprise (CentOS) release.

The recipe will attempt to run `yum -y upgrade` at the end to gracefully
complete the conversion from RedHat to CentOS.

I take absolutely no responsibility if you break your system with this.

Requirements
============

External dependencies include the Opscode yum cookbook, and the yum\_key LWRP.

This recipe will only run on a RedHat Enterprise Linux system.  RHEL 6.0+ support
has not been tested thoroughly, but it should work.

Usage
=====

Append the recipe to a selected node's run\_list with knife:

    knife node run_list add <node name> el2centos

Run `chef-client` on the selected node, and watch for any errors
interrupting which may lead to a "frankenstein" system.

If the recipe detects a platform other than RedHat, it should
automatically remove itself from the run\_list.

Troubleshooting
---------------

If something goes wrong and you are left with a "frankenstein" system,
it might look like this:

    ohai platform
    [
      "linux"
    ]

Also, chef-client may refuse to run, and claim it cannot detect Chef::Node.

Fixes
-----

Try running chef-client with the -N flag.

    chef-client -N <node name>

Try completing the conversion process manually:

    rpm -Uvh --force /var/cache/chef/el2centos/*.rpm
    yum -q makecache
    yum -y upgrade

License and Author
==================

Author: Eric G. Wolfe (<wolfe21@marshall.edu>)

Copyright 2012, Eric G. Wolfe

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

