# Rackspace Networks Detection

This adds an ohai plugin to populate `node[:rackspace][:networks]` with
an array of information about the network setup for the current node.
In the v2 rackspace environment, custom private networks can be created
and nodes are optionally allowed to be granted access. This plugin will
detect what networks the node has access to and provide the relevant
network information, as well as metadata.

## Usage

Add to the runlist. At the very start if possible so detection can occur
at the earliest available point we have available:

* `recipe[rackspace_networks]`

## Sample output:

## Upstream Ohai

This feature will hopefully be added to ohai proper in a coming release.

* http://tickets.opscode.com/browse/OHAI-461

## Information

* Repository: https://github.com/hw-cookbooks/rackspace_networks
* IRC: Freenode @ #heavywater