#
# Cookbook Name:: rackspaceknife
# Recipe:: default
#
# Copyright 2012, Gerald L. Hevener Jr., M.S.
#

# Set which Perl you have.
node.set['rackspaceknife']['which_perl'] = '/usr/bin/perl'

# Set WebService::Rackspace::CloudFiles location.
node.set['rackspaceknife']['perl_modules_dir'] = '/root/modules'
