#
# Cookbook Name:: nsclient
# Recipe:: default
#
# Copyright 2013, Mathew Davies
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

include_recipe "chocolatey"

#this section use chocolatey to install nsclient by calling the correct package for nsclient for the os either 32bit or 64bit
if node['kernel']['machine'] == "x86_64"
  chocolatey "NSClientPlusPlus.x64"
else 
  chocolatey "NSClientPlusPlus.x86"
  end

#installs additional custom scripts from files to script folder in the app path.
#ensure they are supported by your nsc.ini.erb
cookbook_file "#{node['nsclient']['nsclientpath']}scripts/check_available_updates.vbs" do
  source "check_available_updates.vbs"
  action :create
  end
cookbook_file "#{node['nsclient']['nsclientpath']}scripts/restart_w3svc.cmd" do
  source "restart_w3svc.cmd"
  action :create
  end

#use a template for the nsc.ini for settings for nsclient
template "#{node['nsclient']['nsclientpath']}NSC.ini" do
  source "NSC.ini.erb"
  action :create
  notifies :restart, "service[NSClientpp]", :immediately
  end

#install the nsclient and restart it this will ensure changes in settings are loaded each run.
service "NSClientpp" do
  service_name "NSClientpp"
  supports :start => true, :stop => true, :restart => true
  action [:restart, :enable]
  end

