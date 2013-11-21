#
# Cookbook Name:: hollandbackup
# Recipe:: cron
#
# Copyright 2012-2013, David Joos
#

cron "holland-backup" do
	unless node['hollandbackup']['cron']['minute'].nil? || node['hollandbackup']['cron']['minute'].empty?
		minute "#{node['hollandbackup']['cron']['minute']}"
	end
	unless node['hollandbackup']['cron']['hour'].nil? || node['hollandbackup']['cron']['hour'].empty?
		hour "#{node['hollandbackup']['cron']['hour']}"
	end
	unless node['hollandbackup']['cron']['day'].nil? || node['hollandbackup']['cron']['day'].empty?
		day "#{node['hollandbackup']['cron']['day']}"
	end
	unless node['hollandbackup']['cron']['month'].nil? || node['hollandbackup']['cron']['month'].empty?
		month "#{node['hollandbackup']['cron']['month']}"
	end
	unless node['hollandbackup']['cron']['weekday'].nil? || node['hollandbackup']['cron']['weekday'].empty?
		weekday "#{node['hollandbackup']['cron']['weekday']}"
	end
	path "/usr/local/bin:/usr/local/sbin:/bin:/sbin:/usr/bin:/usr/sbin"
	command "holland backup"
end