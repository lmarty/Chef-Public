# encoding: utf-8
include_recipe 'build-essential'
include_recipe 'git'

packages = value_for_platform(
  %w{centos fedora redhat} => {
    'default' => %w{pkgconfig}
  },
  %w{ubuntu} => {
    'default' => %w{pkg-config}
  }
)

packages.each do |p|
  package p
end

directory "#{Chef::Config[:file_cache_path]}/lmctfy" do
  owner 'root'
  group 'root'
  mode 00755
  recursive true
  action :create
end

git "#{Chef::Config[:file_cache_path]}/lmctfy" do
  repository node['lmctfy']['source']['url']
  reference node['lmctfy']['source']['ref']
  action :checkout
end

include_recipe 'lmctfy::source_cli'
include_recipe 'lmctfy::source_cpp'
