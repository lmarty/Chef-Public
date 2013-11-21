#
# Cookbook Name:: hollandbackup
# Recipe:: backupset-config
#
# Copyright 2012-2013, David Joos
#

backupsets = node['hollandbackup']['backupsets']

unless backupsets.nil?
	backupsets.keys.each do |key|
		template "/etc/holland/backupsets/#{backupsets[key]['name']}.conf" do
			source "default.conf.erb"
			owner "root"
			group "root"
			mode 0640
			variables(
				:name => backupsets[key]['name'],
				:backups_to_keep => backupsets[key]['backups_to_keep'],
				:mysql_client_user => backupsets[key]['mysql_client_user'],
				:mysql_client_password => backupsets[key]['mysql_client_password'],
				:compression_method => backupsets[key]['compression_method'],
				:compression_inline => backupsets[key]['compression_inline'],
				:compression_level => backupsets[key]['compression_level'],
				:exclude_databases => backupsets[key]['exclude_databases']
			)
		end
	end
end