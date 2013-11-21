# chocolatey-installer Cookbook

This cookbook allows you to provide an list of package names to be installed by chocolatey, in order.

# Requirements

### Platform

* Windows 2008 R2
* Windows 2012 (Not Tested)

### Cookbooks

* windows 
* chocolatey

# Usage

* Add `recipe[chocolatey-installer::default]` to your run list.

# Attributes

* `default['chocolatey-installer']['packages']` (Default: `{}`)

# Recipes

* default

# Author

Author:: Joe Fitzgerald (joe.fitzgerald@emc.com)
