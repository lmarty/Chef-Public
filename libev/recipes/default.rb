#
# Cookbook Name:: libev
# Recipe:: default
#
# Copyright 2012, Takeshi KOMIYA
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "build-essential"

version = node['libev']['version']
prefix = node['libev']['prefix']

remote_file "#{Chef::Config[:file_cache_path]}/libev-#{version}.tar.gz" do
  source "http://dist.schmorp.de/libev/libev-#{version}.tar.gz"
  not_if {::File.exists?("#{prefix}/lib/libev.a")}
  notifies :run, "script[install-libev]", :immediately
end

script "install-libev" do
  interpreter "bash"
  only_if {::File.exists?("#{Chef::Config[:file_cache_path]}/libev-#{version}.tar.gz")}
  flags "-e -x"
  code <<-EOH
    cd /usr/local/src
    tar xzf #{Chef::Config[:file_cache_path]}/libev-#{version}.tar.gz
    cd libev-#{version}
    ./configure --prefix=#{prefix}
    make
    make install
  EOH
end

file "libev-tarball-cleanup" do
  path "#{Chef::Config[:file_cache_path]}/libev-#{version}.tar.gz"
  action :delete
end
