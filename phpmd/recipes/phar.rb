#
# Cookbook Name:: phpmd
# Recipe:: phar
#
# Copyright 2013, Escape Studios
#

include_recipe "pdepend::phar"

if node[:phpmd][:install_dir] != ""
    phpmd_dir = node[:phpmd][:install_dir]
else
    phpmd_dir = "#{Chef::Config[:file_cache_path]}/phpmd"
end

directory "#{phpmd_dir}" do
    owner "root"
    group "root"
    mode "0755"
    action :create
end

remote_file "#{phpmd_dir}/phpmd.phar" do
    source node[:phpmd][:phar_url]
    mode "0755"
end