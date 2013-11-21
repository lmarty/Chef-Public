#
# Cookbook Name:: re2
# Recipe:: package
#
# Copyright 2013, Jordi Llonch <llonchj@gmail.com>
#
# All rights reserved - Do Not Redistribute
#

node[:re2][:packages].each do |pkg|
  package pkg
end