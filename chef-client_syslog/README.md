# chef-client_syslog cookbook

Send chef-client log to syslog.

reference from: https://gist.github.com/3616423

# Requirements

gem[syslog-logger] to chef's gem_home. (Automatic install it when run recipe[chef-client_syslog::default])

# Usage

  add run_list recipe[chef-client_syslog::default]

# Attributes


default['chef-client']['config_dir']     = "/etc/chef"
default['chef-client']['log']['level']     = :info
default['chef-client']['log']['prog_name'] = "chef-client"
default['chef-client']['log']['facility']  = 8 # get const like  puts ::Syslog::LOG_USER


# Recipes

- default

# Author

Author:: HiganWorks LLC (<sawanoboriyu@higanworks.com>)
