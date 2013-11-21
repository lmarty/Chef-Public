# Arista EOS Cookbook

## Overview
The eos cookbook provides a set of recipes, resources and providers for managing network resources on Arista EOS devices.  The recipes in this cookbook make use of data bags to provide node specific configuration.  

In order to 'attach' a data bag configuration to a node, attributes are used to uniquely identify the node's data bag.   The selector will first look for a data bag with the name found in eos/config/databag.  The default data bag name is eos_config.   In the data bag, you can specify how to unique represent the nodes specific data bag item.  The eos/config/identifier attribute will specify the value to use.  This value can be one of hostname, macaddress or serialnumber.  The default value is hostname.

If you wish to supply your node specific configuration via an alternative mechanism, you can modify eos/config/provider to other and override the get_config method.  This will allow you to return your own hash with configuration values.

## Recipes
Below is a list of the cookbooks provided with a quick summary of each.  Please see the README for each cookbook for any notes specific to usage.

<dl>
<dt>interface</dt> 
<dd>This cookbook provides management of physical interfaces in EOS</dd>

<dt>switchport</dt>
<dd>This cookbook provides the management of switchport resources in EOS</dd>

<dt>portchannel</dt>
<dd>This cookbook provides  management (create, delete) of port-channel interfaces in EOS.  _Note: this recipe only works with EOS 4.10_</dd>

<dt>vlan</dt>
<dd>This cookbook provides management of vlan resources in EOS</dd>
</dl>

## Dependencies
  * Chef 10 or later
  * Arista EOS 4.10
  * Netdev EOS extension

## Contributors
  * Peter Sprygada, Arista Networks

## License
Apache 2.0, See LICENSE file