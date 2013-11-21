# Zenoss Client Cookbook
[![Build Status](https://travis-ci.org/ZCA/zenoss_client-chef-cookbook.png?branch=master)](https://travis-ci.org/ZCA/zenoss_client-chef-cookbook)

The zenoss_client cookbook is intended to replace the functionality that used 
to reside in the client recipe of the [Zenoss cookbook](http://community.opscode.com/cookbooks/zenoss). 
In anticipation of  updates to that cookbook to support Core 4, the client 
logic is being split out to its own cookbook to help ease testing as well as 
reduce dependencies. The updates to the Zenoss cookbook to support core 4 will 
introduce a large number of dependencies, which most clients simply won't need.

Additionally by splitting out the client components, we are laying the
groundwork to later add some support for nodes to self-register using the 
JSON API.

As of 1.1.0 a new LWRP was introduced which will allow nodes to register
themselves with a Zenoss server using the JSON API. Please see the details
on the LWRP below

## Requirements
This cookbook will need access to rubygems.org, or your node must be
pre-configured with a gem source that mirrors rubygems.org

## Usage
Include the default recipe in node's run_list and it will be configured.

If you are an environment where creating a local user for Zenoss to use
is not desirable, be sure to set the value of 
`node['zenoss']['client']['create_local_user']` to false. Doing so will
prevent a local user from being created

## Attributes
The attributes are documented in the default attributes file 
(`attributes/default.rb`). Please refer to that file for details about
the available attributes

## Recipes
Currently the only recipe that exists is the default recipe

## LWRP: zenoss_client
The Zenoss Client LWRP can be used to to register nodes on a Zenoss server.
The primary use case is for nodes to register themselves as part of the
bootstrap process, however the LWRP is constructed in such a way that you could
register other nodes as well (i.e. using nodes discovered via search on a 
central node somewhere).

### Usage
The LWRP makes use of the [zenoss_client gem](http://rubygems.org/gems/zenoss_client)
to communicate with the JSON API. The default recipe in this cookbook will 
handle installing the gem. It is important that you 
`include_recipe "zenoss_client"` before attempting to call the LWRP.

Alternatively you if don't want to run the default recipe for some reason you
will need to handle the `chef_gem "zenoss_client"` installation yourself
somewhere in your run_list prior to calling the LWRP.

#### Actions
* `:add` - Add/register a node with a Zenoss Server. **Default**
* `delete` - Delete a node from a Zenoss Server

#### Attributes
* `device_title` - The display name or title as displayed in the Zenoss UI
  * Type: *String*
  * Default: Name Attribute of the Resource
* `api_host` - The host/ip of your Zenoss API. Generally this will be your Zenoss
  server name, however if you're running Zenoss behind a VIP or something along
  those lines, you could put that here  
  * Type: *String*
  * Default: `node['zenoss']['client']['server'] `
* `api_port` - The HTTP port of your Zenoss API.
  * Type: *Integer*
  * Default: `node['zenoss']['client']['server_port']`
* `api_user` **Required** - The username to use for API authentication
  * Type: *String*
  * Default: *nil*
* `api_password` **Required** - The password to use for API authentication
  * Type: *String*
  * Default: *nil*
* `api_protocol` - The protocol/scheme to use for API communications. Must be
  either *http* or *https*
  * Type: *String*
  * Default: http
* `wait_for` - The amount of time to wait for confirmation that the device has 
  been added. When you add a device via the API, a background job is queued
  and Zenoss will try and collect some basic information about the node.
  Generally, this is a fairly fast operation, but depending on your network
  this might take longer. The default behavior of the LWRP will is to 
  **fire and forget**. That means as soon as the JSON API responds that the 
  background job has been queued, the run will continue. Setting a value for
  this will result in the run **blocking** until the node is registered or
  the amount of elapsed time exceeds this value
  * Type: *Integer*
  * Default: 0
* `ip` - The IP that is to be set as the manage IP of the device
  * Type: *String*
  * Default: `node['ipaddress']`
* `collector` - The collector aka 'remote collector' that the device should be
  assigned to.
  * Type: *String*
  * Default: "localhost"
* `device_class` - The Device Class that the node should get put in
  * Type: *String*
  * Default: "/Devices/Server"
* `comments` - Comments to put on the Device
  * Type: *default*
  * Default: ""

### Examples
The [testing recipe](https://github.com/ZCA/zenoss_client-chef-cookbook/tree/master/test/cookbooks/zenoss_client_test/recipes/client_lwrp.rb)
used to test this cookbook is a good place to look for example usages, but here
are a couple of examples.

Example 1: Register **this** node

    # Use the 'fire and forget' method, and don't wait for confirmation
    zenoss_client node.name do
      action :add
      api_user "MyZenossAPIUser"
      api_password "MyZenossAPIPassword"
    end

Example 2: Register some other node

    # Register a new node name 'TestDevice1'.
    # Wait **up to** 120 seconds for the node to be registered
    # Register the device with a management IP of 1.1.1.1
    zenoss_client "TestDevice1" do
      action :add
      api_user "MyZenossAPIPassword"
      api_password node['zenoss']['client']['test']['api_password']
      wait_for 120
      ip  "1.1.1.1"
    end

Example 3: Delete **this** node

    # Delete *this* node
    zenoss_client node.name do
      action :delete
      api_user "MyZenossAPIUser"
      api_password "MyZenossAPIPassword"
    end

## Authors
Author:: David Petzel (davidpetzel@gmail.com)

## Testing
This cookbook is setup to be tested using 
[test-kitchen](https://github.com/opscode/test-kitchen) and supporting tools.
You should ensure you have the following set of utilities on your machine:

* [Vagrant](http://www.vagrantup.com/)
* [Test Kitchen](https://github.com/opscode/test-kitchen)
* [Berkshelf](http://berkshelf.com/)
* [vagrant-berkshelf](https://github.com/riotgames/vagrant-berkshelf)
* [vagrant-omnibus](https://github.com/schisamo/vagrant-omnibus)

You should refer to the Test Kitchen documentation for more in depth information
around running tests, however here is a quick rundown.

You can see the available test suites by running via the `kitchen list` command.
This will show you each combination that is available for testing. 

You can run all tests by running `kitchen test`. Or if you only want to test
Centos 6.4, you could run `kitchen test zenoss-client-centos-64`. You can also
use regular expression in place of the suite name to run a subset of all suites

Currently the platforms and suite(s) are configured to provide test coverage
of both Chef 10 and Chef 11


