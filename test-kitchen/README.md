Description
===========

This cookbook installs and configures Test-Kitchen to be used for testing Chef
cookbooks.

Requirements
============

Depends on:

* [build-essential](http://ckbk.it/build-essential)
* Joshua Timberman's [Vagrant cookbook](https://github.com/jtimberman/vagrant-cookbook)
* Christopher Peplin's fork of Joshua Timberman's [VirtualBox cookbook](https://github.com/peplin/virtualbox-cookbook)

This has only been tested with Chef 11.6 on Ubuntu 13.04.

## Platform

* Debian
* Ubuntu

May work with or without modification on other Debian derivatives.

Recipes
=======

## default

Installs Test Kitchen from gems to use with Vagrant.

Attributes
==========

* `['test-kitchen']['settings']` - hash of key and values to put into your .kitchen.yml
* `['test-kitchen']['version']` - version of Test-Kitchen we want to install, default is '1.0.0.beta.2'

Resources/Providers
===================

nothing yet.

License and Author
==================

Author:: Matt Ray (<matt@opscode.com>)

Copyright 2013 Opscode, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
