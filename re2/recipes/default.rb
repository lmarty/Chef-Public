#
# Cookbook Name:: re2
# Recipe:: default
#
# Copyright 2013, Jordi Llonch <llonchj@gmail.com>
#
# All rights reserved - Do Not Redistribute
#

include_recipe "re2::#{node[:re2][:install_method]}"

