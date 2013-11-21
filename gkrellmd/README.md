# gkrellmd
[![Build Status](https://travis-ci.org/locomote-cookbooks/gkrellmd.png?branch=master)](https://travis-ci.org/locomote-cookbooks/gkrellmd)

This cookbook installs and configures gkrellm daemon.

# Requirements

This cookbook has been tested on CentOS and RHEL version 6.3 but should work for Ubuntu and Debian.

# Attributes

* `node['gkrellmd']['port']` - the port the daemon will use. Default is 19150.
* `node['gkrellmd']['allowed_hosts']` - Restrict acces to particular hosts. Empty array (default) allows all.

# Usage

Just include `recipe[gkrellmd]` in your run_list.

# License and Author
Author:: Chris (<chris@locomote.com>)

Copyright (c) 2013, Locomote Pty Ltd.

Licensed under BSD license.

    http://opensource.org/licenses/BSD-2-Clause
