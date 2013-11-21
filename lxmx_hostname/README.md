# lxmx_hostname
[![Build Status](https://travis-ci.org/lxmx/chef-hostname.png?branch=master)](https://travis-ci.org/lxmx/chef-hostname)

## Usage

* To set and persist a hostname, set `node['net']['hostname']`.
* To set and persist an FQDN, set `node['net']['FQDN']` and `node['net']['IP']`.
* Then include `recipe[lxmx_hostname]` in your run_list.

## Requirements

### Platform

The following platforms are supported by the cookbook:

* ubuntu
* debian
* centos
* redhat
* gentoo

### Cookbooks

This cookbook depends on the following external cookbooks:

* hostsfile - [github](https://github.com/customink-webops/hostsfile), [community](http://community.opscode.com/cookbooks/hostsfile).

## Recipes

### default

Sets and persists node hostname using different approaches on different platforms.

## Attributes

* `node['net']['hostname']` - node hostname to set and persist.
* `node['net']['FQDN']` - (optional) node FQDN to set and persist.
* `node['net']['IP']`- node IP address, set if you're setting an FQDN.

## License

Copyright:: Vasily Mikhaylichenko and LxMx.

Licensed under BSD license.

    http://opensource.org/licenses/BSD-2-Clause


