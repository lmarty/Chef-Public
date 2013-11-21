Description [![Build Status](https://travis-ci.org/hipsnip-cookbooks/admin-user.png)](https://travis-ci.org/hipsnip-cookbooks/admin-user)
===========
This cookbook is used to set up a single shared admin user on a host, and then set
up a list of SSH keys to log in to it.

> NOTE This cookbook does not use search, it simply looks at the contents of a specific data bag


Compatibility
=============
Tested on:

* Ubuntu 10.04
* Ubuntu 12.04
* CentOS 6.3
* CentOS 5.8

with Chef versions `10.18` and `11.04`.
Assumed to work with other Debian and RedHat based distros as well.


Attributes
==========

    ['admin-user']['user'] = The admin user to create (defaults to "admin")
    ['admin-user']['group'] = The primary group for the admin user (defaults to "admin")
    ['admin-user']['data_bag'] = The data bag to load the SSH keys from (defaults to "users")
    ['admin-user']['authorized_keys'] = List of key names that will be enabled on the host (defaults to all)


Usage
=====
With the default settings, this cookbook assumes that you have a data bag called "users",
with a data bag item called "admin" - the name of the data bag item we look for is the
same at the user defined in `['admin-user']['user']`. The data bag item should look
something like this:

    {
        "id" : "admin",
        "authorized_keys" : {
            "jack" : "ssh key for jack goes here",
            "jill" : "ssh key for jill goes here"
        }
    }

By default, the keys listed under "authorized_keys" will all be added for the "admin" user.

### Restricting keys
If you only want to allow a subset of users to have access, you can change `['admin-user']['authorized_keys']` to
an array with a list of key names. For the example above, you could set it to `["jack"]` to only copy the SSH
key for "jack", and not "jill".


Development
============
Please refer to the Readme [here](https://github.com/hipsnip-cookbooks/cookbook-development/blob/master/README.md)


License and Author
==================

Author:: Adam Borocz ([on GitHub](https://github.com/motns))

Copyright:: 2013, HipSnip Ltd.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
