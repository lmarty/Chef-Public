chef-npm-registry [![Build Status](https://travis-ci.org/coryroloff/chef-npm-registry.png?branch=master)](https://travis-ci.org/coryroloff/chef-npm-registry) [![Dependency Status](https://gemnasium.com/coryroloff/chef-npm-registry.png)](https://gemnasium.com/coryroloff/chef-npm-registry)
===========

The npm_registry cookbook installs and configures an NPM package registry using the official [NPM project layout](https://github.com/isaacs/npmjs.org). Includes support for replicating the official isaacs NPM registry (continuously or scheduled).

If you are installing this locally (such as with Vagrant), it is recommended you set the following attributes:

* `node['couch_db']['httpd']['bind_address'] = '0.0.0.0'`
* `node['couch_db']['httpd']['secure_rewrites'] = false`

This cookbook also makes use of the couch_db attributes:

* `node['couch_db']['config']['couchdb']['httpsd']`
* `node['couch_db']['config']['httpd']['port']`
* `node['couch_db']['config']['couchdb']['database_dir']`

Requirements
============

Platform
--------

* Ubuntu

Tested on:

* Ubuntu 12.04
* Ubuntu 12.10

Cookbooks
---------

Requires Opscode's [git](http://community.opscode.com/cookbooks/git) and [couchdb](http://community.opscode.com/cookbooks/couchdb) cookbooks and Marius Ducea's [nodejs](http://community.opscode.com/cookbooks/nodejs) cookbook. Opscode's [cron](http://community.opscode.com/cookbooks/cron) cookbook is only required if using scheduled replication. See Attributes and Usage for more information.

Attributes
==========

See the attributes/defaults.rb for default values.

* `node['npm_registry']['git']['url']` - The URL to NPM's registry repository. Attribute is provided in case the repository is ever moved.
* `node['npm_registry']['git']['reference']` - The branch or tag name to checkout from the Git repository.
* `node['npm_registry']['isaacs']['registry']['url']` - The URL to the official NPM registry (used for replication).
* `node['npm_registry']['replication']['flavor']` - Allowed values: `none`, `scheduled` or `continuous`
* `node['npm_registry']['replication']['scheduled']['minute']` - The scheduled minute value.
* `node['npm_registry']['replication']['scheduled']['hour']` - The scheduled hour value.
* `node['npm_registry']['replication']['scheduled']['weekday']` - The scheduled weekday value.
* `node['npm_registry']['replication']['scheduled']['day']` - The scheduled day value.
* `node['npm_registry']['replication']['scheduled']['month']` - The scheduled month value.

Usage
=====

To install and configure the default NPM package registry, use:

`{ "run_list": ["recipe[npm_registry]"] }`

For scheduled replication, use:

`{ "run_list": ["recipe[cron]", "recipe[npm_registry]"] }`

Testing
=======

This cookbook includes support for running tests via FoodCritic, ChefSpec, Kitchen and Minitest.

1. Install [Vagrant](http://downloads.vagrantup.com), Gem, Cookbook and Vagrant plugin dependencies:

	```bash
	vagrant plugin install vagrant-berkshelf
	bundle install
	berks install
	```

3. Run Vagrant instance with default attributes:

	```bash
	vagrant up
	```

4. Run FoodCritic, ChefSpec, Kitchen and Minitest:

	```bash
	strainer test
	```