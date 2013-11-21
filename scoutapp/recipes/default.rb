#
# Cookbook Name:: scoutapp
# Recipe:: default
#
# Copyright 2011, Efactures
#
# Apache 2.0 Licence
#

# bugs gem freshly installed like scout_scout can't be run on the same chef-client runtime 
# Need a fix for this
# Install
include_recipe "scoutapp::install"

# Setup
include_recipe "scoutapp::setup"