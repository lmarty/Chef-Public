#
# Cookbook Name:: x2go
# Recipe:: default
#
# Copyright 2013, Rilindo Foster <rilindo.foster@monzell.com
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

default['x2go']['server']['pkg'] = 'x2goserver'
default['x2go']['server']['svc'] = 'x2gocleansessions'
default['x2go']['client']['pkg'] = 'x2goclient'

case node['platform_family']
when "centos","rhel"
  if node['platform_version'] >='6.0'
    default['x2go']['install_flavor'] = 'yum_repo'
  end
end