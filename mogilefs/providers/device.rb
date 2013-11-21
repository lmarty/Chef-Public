#
# Cookbook Name:: mogilefs
# Provider:: device
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
  unless @device.exists
    Chef::Log.info "[mogilefs_device] creating device:#{new_resource.name} devid: #{new_resource.devid}"
    execute "mogadm --trackers=#{new_resource.trackers.join(',')} device add #{new_resource.name} #{new_resource.devid}"
    
    new_resource.updated_by_last_action(true)
  end
  
  directory "#{node[:mogilefs][:mogstored][:doc_root]}/dev#{new_resource.devid}" do
    owner "root"
    group "root"
    mode 0755
    recursive true
  end
end

action :alive do
  if @device.exists
    Chef::Log.info "[mogilefs_device] changing device #{new_resource.name} state to [alive]"
    connection.change_device_state(new_resource.name, new_resource.devid, "alive")
    new_resource.updated_by_last_action(true)
  end
end

action :down do
  if @device.exists
    Chef::Log.info "[mogilefs_device] changing device #{new_resource.name} state to [down]"
    connection.change_device_state(new_resource.name, new_resource.devid, "down")
    new_resource.updated_by_last_action(true)
  end
end

action :dead do
  if @device.exists
    Chef::Log.info "[mogilefs_device] changing device #{new_resource.name} state to [dead]"
    connection.change_device_state(new_resource.name, new_resource.devid, "dead")
    new_resource.updated_by_last_action(true)
  end
end

def load_current_resource
  @device = Chef::Resource::MogilefsDevice.new(new_resource.name)
  @device.trackers(new_resource.trackers)
  exists = connection.get_devices.any? do |device|
    new_resource.devid.to_s == device['devid']
  end
  @device.exists(exists)
end
