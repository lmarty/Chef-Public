#
# Cookbook Name:: sox_mp3
# Recipe:: default
#
# Author:: Gabriel Cebrian (<gabceb@gmail.com>)
#
# Copyright 2013, Gabriel Cebrian.
#
# Licensed under the MIT License
#

case node['platform']
when "ubuntu"
	include_recipe "sox_mp3::install_ubuntu"
else
	Chef::Log.error "This cookbook is only supported in Ubuntu. Pull requests are welcome to support more environments"
    return
end