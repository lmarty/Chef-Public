#
# Cookbook Name:: phpcs
# Recipe:: composer
#
# Copyright 2013, Escape Studios
#

include_recipe "composer"

phpcs_dir = "#{Chef::Config[:file_cache_path]}/phpcs"

directory "#{phpcs_dir}" do
	owner "root"
	group "root"
	mode "0755"
	action :create
end

#figure out what version to install
if node[:phpcs][:version] != "latest"
	version = node[:phpcs][:version]
else
	version = "*.*.*"
end

#composer.json
template "#{phpcs_dir}/composer.json" do
	source "composer.json.erb"
	owner "root"
	group "root"
	mode 0600
	variables(
		:version => version,
		:bindir => node[:phpcs][:prefix]
	)
end

#composer update
execute "phpcs-composer" do
	user "root"
	cwd phpcs_dir
	command "composer update"
	action :run
end