#
# Cookbook Name:: rackspaceknife
# Recipe:: default
#
# Copyright 2011, Gerald L. Hevener, Jr, M.S., Marshall University
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
include_recipe "perl"

case node['platform_family']
  when "redhat"
    %w{ perl-IPC-Run perl-version findutils }.each do |perlpkg|
      package perlpkg
      cpan_module "Getopt::Declare" 
      cpan_module "WebService::Rackspace::CloudFiles"
  end
  when "debian"
    %w{ libgetopt-declare-perl libipc-run-perl libdatetime-perl findutils }.each do |perlpkg|
      package perlpkg
      cpan_module "WebService::Rackspace::CloudFiles"
    end
end

template "/usr/local/bin/rackspaceknife.pl" do
  mode "0755"
  owner "root"
  group "root"
  source "rackspaceknife.pl.erb" 
  action :create
end

directory node.set['rackspaceknife']['perl_modules_dir'] do
  owner "root"
  group "root"
  mode 0755
  action :create
  not_if "test -d #{node.set['rackspaceknife']['perl_modules_dir']}"
end

#bash "where_is_getopt_declare1" do
#  user "root"
#  cwd "/tmp"
#  code <<-EOH
#updatedb
#  EOH
#end
 
#bash "where_is_getopt_declare2" do
#  user "root"
#  cwd "/tmp"
#  code <<-EOH
#sleep 60
#  EOH
#end

#bash "where_is_getopt_declare2" do
#  user "root"
#  cwd "/tmp"
#  code <<-EOH
#locate Declare.pm
#  EOH
#end

 
# Where is WebService::RackspaceCloudFiles.pm.
#system(" updatedb" )
#cloudfiles_pm = `locate WebService/Rackspace/CloudFiles.pm`
#puts("Cloudfiles is at: #{cloudfiles_pm}")

# Copy CloudFiles.pm to /root/modules
#script "cp_CloudFiles.pm" do
#  owner "root"
#  group "root"
#  mode "0755"
   
#  action :action # see actions section below
#end

# Copy CloudFiles.pm to /root/modules
#system(" cp #{cloudfiles_pm} #{node.set['rackspaceknife']['perl_modules_dir']}/ ")
#`cp #{cloudfiles_pm} /root/modules/`
