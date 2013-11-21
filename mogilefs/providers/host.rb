#
# Cookbook Name:: mogilefs
# Provider:: host
#
# Author:: Jamie Winsor (<jamie@enmasse.com>)
#
# Copyright 2011, En Masse Entertainment, Inc.
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

include EnMasse::MogileFS::Admin

action :create do
  unless @mfs_host.exists
    Chef::Log.info "[mogilefs_host] creating host #{new_resource.name}"
    connection.create_host(new_resource.name, new_resource.args)    
    new_resource.updated_by_last_action(true)
  end
end

action :delete do
  if @mfs_host.exists
    Chef::Log.info "[mogilefs_host] deleting host #{new_resource.name}"
    connection.delete_host("#{new_resource.name}:#{new_resource.port}")
    new_resource.updated_by_last_action(true)
  end
end

action :update do
  if @mfs_host.exists
    Chef::Log.info "[mogilefs_host] updating host #{new_resource.name}"
    connection.update_host("#{new_resource.name}:#{new_resource.port}", new_resource.args)
    new_resource.updated_by_last_action(true)
  end
end

def load_current_resource
  new_resource.args.merge!(
    :port => new_resource.port,
    :ip => new_resource.ipaddress,
    :status => new_resource.status
  )
  @mfs_host = Chef::Resource::MogilefsHost.new(new_resource.name)
  @mfs_host.trackers(new_resource.trackers)
  exists = connection.get_hosts.any? do |host|
    (new_resource.name == host['hostname'] || new_resource.ipaddress == host['hostip'])
  end
  @mfs_host.exists(exists)
end
