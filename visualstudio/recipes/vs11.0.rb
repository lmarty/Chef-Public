#
# Author:: Steve Craig <support@smashrun.com>
# Cookbook Name:: visualstudio
# Recipe:: vs2012
#
# Copyright 2013, Smashrun, Inc.
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

log("begin vs11.0") { level :debug }
log("running vs11.0") { level :info }

###
### mount the cdrom / image
### this will be left as an exercise for the individual
### set attribute for install media location
###


setup = "#{node['vs']['media']}\\#{node['vs']['setup']}"
execute setup do
  action :nothing
  timeout 1800
  command %Q(#{setup} #{node['vs']['install']})
  ignore_failure true
end

# what do the settings inside the node['vs']['deploy'] file mean?
# no one knows; microsoft does not document them
# http://social.msdn.microsoft.com/Forums/vstudio/en-US/58ab62ca-1b89-429e-ab3c-ebed44c16930/admindeploymentxml-documentation
# http://social.msdn.microsoft.com/Forums/vstudio/en-US/1a162e32-b047-458f-a884-6cb8f1e24abe/missing-documentation-on-admindeploymentxml
templated = nil
begin
  templated = resources(:template => "#{node['vs']['deploy_template']}")
    rescue Chef::Exceptions::ResourceNotFound
  templated = template "#{node['vs']['tempdir']}\\#{node['vs']['deploy']}" do
    source "#{node['vs']['deploy_template']}"
    backup 10
    notifies :run, resources(:execute => setup), :immediately
  end
end

ruby_block "installing Visual Studio #{node['vs']['version']} #{node['vs']['product'].capitalize} if necessary" do
  block {}
  only_if do
    install = true
    begin
      require 'win32/registry'
      raccess = ::Win32::Registry::KEY_READ
      regbase = "#{node['vs']['installreg']}"
      begin
        ::Win32::Registry::HKEY_LOCAL_MACHINE.open(regbase, raccess) do |reg|
          if "#{reg['Install']}" == '1'
            install = false
          end
        end
      rescue
        # rescue in case the key is nil, in which case we need to install
      end
    end
    install
  end
  notifies :run, resources(:execute => setup), :immediately
end

unless node['vs']['feedback'].nil?
  include_recipe "visualstudio::feedback"
end

log("end vs11.0") { level :info }
