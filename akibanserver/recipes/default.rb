#
# Cookbook Name:: akibanserver
# Recipe:: default
#
# Copyright 2012, Akiban Technologies
#
# Apache License
#

include_recipe "akibanserver::setup_repos"
include_recipe "akibanserver::required_packages"
include_recipe "akibanserver::install"
