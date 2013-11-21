#
# Cookbook Name:: hollandbackup
# Recipe:: main-config
#
# Copyright 2012-2013, David Joos
#

backupsets = node['hollandbackup']['backupsets']

template "/etc/holland/holland.conf" do
	source "holland.conf.erb"
	owner "root"
	group "root"
	mode 0640
	variables(
		:backupsets => backupsets
	)
end