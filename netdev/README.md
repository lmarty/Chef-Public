# Netdev Cookbook

## Overview
The netdev cookbook provides a set of lightweight resource providers that are intended to represent network resources in a non-vendor specific way.   The lightweight resource providers describe network resources running on network devices.  These resource abstractions have been developed as a starting point for automating network elements using Opscode Chef.

## Resources
The resources provided here are summarized below.  

<dl>
<dt>interface</dt> 
<dd>This resource provides an abstraction for managing physical interfaces on network elements.</dd>

<dt>l2_interface</dt>
<dd>This resource provides an abstraction for creating and deleting layer 2 interfaces on network devices</dd>

<dt>lag</dt>
<dd>This resource provides an abstraction for creating and deleting lag interfaces</dd>

<dt>vlan</dt>
<dd>This resource provides an abstraction for creating and deleting vlans</dd>
</dl>

## Contributing
The intention of this library of lightweight resource providers is to grow over time to encompass as much of the network resources as makes sense.   Contributions are gladly accepted either as pull requests or by opening an issue and requesting a specific LWRP.

## Dependencies
  * Chef 10 or later
  * One or more provider cookbook implementations

## Contributors
  * Peter Sprygada, @privateip
  * Jeremy Schulman, @nwkautomaniac

## License
  Apache 2.0, See LICENSE file