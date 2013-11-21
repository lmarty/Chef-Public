#
# Cookbook Name:: ipf_configure
# Recipe:: merge
#
# Copyright 2013, HiganWorks LLC.

%w(pass_icmp pass_in pass_out block_in block_out ports_block_in ports_pass_in ports_pass_in_by_ip ports_block_out ports_pass_out).each do |key|
  node.set['ipf']['rules'][key.to_sym].uniq!
end

include_recipe 'ipf::default'
