#
# Cookbook Name:: pdepend
# Recipe:: phar
#
# Copyright 2013, Escape Studios
#

if node[:pdepend][:install_dir] != ""
    pdepend_dir = node[:pdepend][:install_dir]
else
    pdepend_dir = "#{Chef::Config[:file_cache_path]}/pdepend"
end

directory "#{pdepend_dir}" do
    owner "root"
    group "root"
    mode "0755"
    action :create
end

remote_file "#{pdepend_dir}/pdepend.phar" do
    source node[:pdepend][:phar_url]
    mode "0755"
end