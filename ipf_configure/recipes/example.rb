#
# Cookbook Name:: ipf_configure
# Recipe:: example
#
# Copyright 2013, HiganWorks LLC.
#


node.set['ipf']['rules']['pass_in'] << 'any'
node.set['ipf']['rules']['pass_in'] << '192.168.100.0/24'

