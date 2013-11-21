Description
===========
Installs System Wide RVM via RVM recipe (you can use an attribute to specify version of ruby to be installed).  RVM is configured for the specified user to work on boot.

Then Rails is installed (again version can be specified by attribute).

Requirements
============
#Platforms:
I have only tested this recipe on Ubuntu 10.04, I put in metadata.rb that all version of Ubuntu are supported.

#Depends:
This recipe depends on the rvm recipes.

Attributes
==========
default[:rails_rvm][:user] = user to install/setup rvm and rails under

You can get more info about creating a password hash at:
http://wiki.opscode.com/display/chef/Resources#Resources-User 
default[:rails_rvm][:password] = password hash for the user  

ironruby, jruby, rbx, ree, 1.8.7, 1.9.2, 1.9.3
default[:rails_rvm][:rvm_version] = version of ruby to be installed.

default[:rails_rvm][:rails_version] = version of rails to be installed.

Usage
=====
This recipe can be used by other recipes/applications and the default rails_rvm attributes can be overriden.  I will post locomotive_cms recipe as an example soon.
