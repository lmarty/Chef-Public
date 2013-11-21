# encoding: utf-8
include_recipe 'gflags::cpp'
include_recipe 'protobuf::cpp'
include_recipe 're2'

include_recipe 'lmctfy::cgroups'
include_recipe "lmctfy::#{node['lmctfy']['install_type']}"
include_recipe 'lmctfy::lmctfy_init'
