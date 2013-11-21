#
# Cookbook Name:: oclint
# Recipe:: package
#
# Copyright 2013, Chris Streeter
#
# All rights reserved
#

local_file = "oclint-#{node[:oclint][:version]}-x86_64-linux-ubuntu-12.04"

###############################################################################
# Get the remote package

remote_file "#{Chef::Config[:file_cache_path]}/#{local_file}.tar.gz" do
    source "#{node[:oclint][:url]}"
    backup false
end


###############################################################################
# Untar the downloaded packages

execute "untar oclint" do
    command "tar xzf #{local_file}.tar.gz"
    creates "#{Chef::Config[:file_cache_path]}/#{local_file}"
    cwd "#{Chef::Config[:file_cache_path]}"
end


###############################################################################
# Install OCLint

[ "bin", "lib" ].each do |dir|
    directory "/usr/local/#{dir}" do
        owner "root"
        group "root"
        mode 00755
        action :create
        recursive true
    end
end

bash "install-oclint" do
    code "cp bin/oclint* /usr/local/bin/ && cp -rp lib/* /usr/local/lib/"
    cwd "#{Chef::Config[:file_cache_path]}/#{local_file}"
    not_if { ::File.exists?("/usr/loca/bin/oclint-#{node[:oclint][:version]}") }
end
