#
# Cookbook Name:: backup-manager
# Recipe:: default
#
# Copyright 2011, Efactures
#
# Apache 2.0
#

# Installing backup-manager

package "backup-manager" do
  action :install
end

# Creating cron entries

cron "backup-manager" do
  minute "30"
  hour "8"
  path "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/X11R6/bin"
  command "backup-manager >> /dev/null 2>&1"
end

# Generating the configuration file

template "/etc/backup-manager.conf" do
  source "backup-manager.conf.erb"
  owner "root"
  group "root"
  mode 0640
end