#
# Cookbook Name:: tfchefint
# Recipe:: artifact_update_hook
# Author:: Julian C. Dunn (<jdunn@opscode.com>)
#
# Copyright 2013, Opscode, Inc.
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

include_recipe "tfchefint::hooks"

template "/opt/collabnet/teamforge/hooks/asynchronous/artifact_update" do
  source "artifact_update.erb"
  variables(
    :bagname => node['tfchefint']['artifact_update_hook']['app_bag_name'],
    :target_env_field => node['tfchefint']['artifact_update_hook']['target_env_field'],
    :frsid_field => node['tfchefint']['artifact_update_hook']['frsid_field'],
    :appname_field => node['tfchefint']['artifact_update_hook']['appname_field']
  )
  owner "sf-admin"
  group "sf-admin"
  mode  00755
  action :create
end
