maintainer       "David Radcliffe"
maintainer_email "radcliffe.david@gmail.com"
license          "Apache 2.0"
description      "Configures rackconnect sudoers"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
name             "rackconnect"
version          "0.1.0"
depends          "sudo"
supports         "centos"

recipe "rackconnect", "Setup the rackconnect sudoers fragment."