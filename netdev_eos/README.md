# netdev_eos Cookbook

## Overview
The cookbooks found here are an implementation of the lightweight resource providers found in the [NetdevOps cookbooks](https://github.com/NetdevOps/chef-netdev-stdlib).  The implementation provides an abstraction for managing network resources.   These cookbooks provide a set of recipes and providers to implementing them on EOS based network elements.


## Recipes
Below is a list of the cookbooks provided with a quick summary of each.  Please see the README for each cookbook for any notes specific to usage.

<dl>
<dt>interface</dt> 
<dd>This cookbook provides an implementation of the resources found in netdev::interface.  It provides management of physical interfaces in EOS</dd>

<dt>l2_interface</dt>
<dd>This cookbook provides an implementation of the resources found in netdev::l2_interface.   In provides the management of switchport resources in EOS</dd>

<dt>lag</dt>
<dd>This cookbook provides an implementation of the resources found in netdev::lag.  It allows for the management (create, delete) of port-channel interfaces in EOS</dd>

<dt>vlan</dt>
<dd>This cookbook provides an implementation of the resources found in netdev::vlan.  It allows for the management of vlan resources in EOS</dd>
</dl>

## Dependencies
  * Chef 10 or later
  * netdev cookbook
  * netdev extension 

## Contributors
  * Peter Sprygada, Arista Networks

## License
  Apache 2.0, See LICENSE file