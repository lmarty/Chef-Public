# -*- coding: undecided -*-
#
# Cookbook Name:: robot
# Recipe:: default
#
# Copyright 2012, Pavlo Baron (pb[at]pbit[org])
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

remote_file "#{Chef::Config[:file_cache_path]}/robot.tar.gz" do
  source "http://robotframework.googlecode.com/files/robotframework-#{node['robot']['version']}.tar.gz"
  mode "0644"
end

execute "gzip & tar" do
  command "cd #{Chef::Config[:file_cache_path]}; gzip -cd robot.tar.gz | tar xfv -; mv robotframework-#{node['robot']['version']} /opt/robot"
  action :run
end

execute "install" do
  command "cd /opt/robot; python setup.py install"
  action :run
end
