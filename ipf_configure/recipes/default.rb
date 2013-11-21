#
# Cookbook Name:: ipf_configure
# Recipe:: default
#
# Copyright 2013, HiganWorks LLC.
#

node.set['ipf']['rules']['pass_icmp']           = ['any']
node.set['ipf']['rules']['pass_in']             = []
node.set['ipf']['rules']['pass_out']            = []
node.set['ipf']['rules']['block_in']            = []
node.set['ipf']['rules']['block_out']           = []
node.set['ipf']['rules']['ports_block_in']      = []
node.set['ipf']['rules']['ports_pass_in']       = ['22']
node.set['ipf']['rules']['ports_pass_in_by_ip'] = []
node.set['ipf']['rules']['ports_block_out']     = []
node.set['ipf']['rules']['ports_pass_out']      = []
