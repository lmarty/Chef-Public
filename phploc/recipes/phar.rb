#
# Cookbook Name:: phploc
# Recipe:: phar
#
# Copyright 2013, Escape Studios
#

if node[:phploc][:install_dir] != ""
    phploc_dir = node[:phploc][:install_dir]
else
    phploc_dir = "#{Chef::Config[:file_cache_path]}/phploc"
end

directory "#{phploc_dir}" do
    owner "root"
    group "root"
    mode "0755"
    action :create
end

remote_file "#{phploc_dir}/phploc.phar" do
    source node[:phploc][:phar_url]
    mode "0755"
end