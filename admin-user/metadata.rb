name             "admin-user"
maintainer       "HipSnip Ltd."
maintainer_email "adam@hipsnip.com"
license          "Apache 2.0"
description      "Sets up a shared admin user to manage the system"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.1.2"
supports 'ubuntu', ">= 10.04"
supports 'centos', ">= 5.8"

depends "sudo", ">= 2.2.0"

attribute "admin-user/user",
  :display_name => "User",
  :description => "The admin user to create",
  :type => "string",
  :default => "admin"

attribute "admin-user/group",
  :display_name => "Group",
  :description => "The primary group for the admin user",
  :type => "string",
  :default => "admin"

attribute "admin-user/data_bag",
  :display_name => "Data Bag",
  :description => "The data bag to load the SSH keys from",
  :type => "string",
  :default => "users"

attribute "admin-user/authorized_keys",
  :display_name => "Authorized Keys",
  :description => "List of key names that will be enabled on the host"