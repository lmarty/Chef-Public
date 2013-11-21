#
# Cookbook Name:: mailserver_provisioning
# Recipe:: drbd_inplace_upgrade
#
# Copyright (C) 2012 Justin Witrick
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#      http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# 

include_recipe "#{@cookbook_name}"

stop_file = node['drbd']['initialized']['stop_file']
drbd_st_fi = node['drbd']['stop_file']

execute "create stop files" do
  command "echo 'Creating stop files'"
  not_if { ::File.exists?(drbd_st_fi) }
  notifies :create, "extended_drbd_immutable_file[#{stop_file}]", :immediately
  notifies :create, "extended_drbd_immutable_file[#{drbd_st_fi}]", :immediately
end

# vim: ai et ts=2 sts=2 sw=2 ft=ruby
