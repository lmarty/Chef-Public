clonezillalive Cookbook
=======================

Deploy Clonezilla-Live for network-booting.

Clonezilla then allows to save and restore images of hard-disks.

If the image is for windows and prepared for example with sysprep, it can be
used to install several machines over and over again.

Requirements
------------

The development of this cookbook happens on debian wheezy (7.1), which makes
this the supported platform.

#### cookbooks
 - `tftp`: For the booting
 - `nfs`: For the image store

Attributes
----------

[None yet]


Usage
-----
#### clonezillalive::default

This recipe does nothing. Its there to play it safe if I want to add providers
and resources to this cookbook.

#### clonezillalive::server

This recipe grabs the clonezilla live image and unpacks the files needed for
network-boot. Then it installs tftp and syslinux and configures pxe-booting for
the clonezilla image.

Contributing
------------

Standard opensource cookbook rules apply:

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. <del>Write tests for your change (if applicable)</del>
5. <del>Run the tests, ensuring they all pass</del>
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Arnold Krille (for bcs kommunikationslösungen)
