#
# Cookbook Name:: oclint
# Recipe:: default
#
# Copyright 2013, Chris Streeter
#
# All rights reserved
#

include_recipe "oclint::#{node[:oclint][:install_method]}"
