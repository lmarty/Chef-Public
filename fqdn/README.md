# fqdn cookbook

# Description
Include this recipe in your run_list, and it will make sure that your
node has a properly configured FQDN. It is opinionated, so that your
hostname equals your FQDN like Bob intended. You can override this
behavior by setting the attribute 'fqdn_as_hostname' to false.

# Requirements
line cookbook
hostsfile cookbook

# Usage
Include the default recipe in a base role or wrapper recipe, somewhere between selinux and ntp.

# Attributes
default['fqdn_as_hostname']=true

# Recipes
debian.rb
rhel.rb

# Author
Author:: Sean OMeara (<someara@opscode.com>)
