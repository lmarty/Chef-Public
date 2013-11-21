Description
===========

This cookbook installs and builds an [iPXE](http://ipxe.org/) boot image from source so it may have [iPXE scripts embedded](http://ipxe.org/scripting). The Ubuntu `iPXE` package only contains static roms, other distros may have more useful packages. This iPXE boot image may be used to boot from an image at a URL, from a SAN or from a self-created VLAN for example.

The iPXE cookbook may be used in conjunction with the [pxe_dust cookbook](https://github.com/opscode-cookbooks/pxe_dust) to [chainload iPXE](http://ipxe.org/howto/chainloading) from PXE.

Requirements
============

The `metadata.rb` requires the `build-essential` and `git` cookbooks so there is a working build tool chain.

Recipes
=======

install
-------
Installs the required dependencies and checks out the iPXE source from http://git.ipxe.org/ipxe.git.

chainload
---------
Embeds a iPXE script into a chainloadable PXE image.

License and Author
==================

Author:: Matt Ray (<matt@opscode.com>)

Copyright 2012 Opscode, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
