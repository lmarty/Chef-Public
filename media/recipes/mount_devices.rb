#
# Cookbook Name:: media
# Recipe:: mount_devices
#
# Copyright (C) 2013 Kannan Manickam
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

log "Setting up media devices: #{node['media']['devices'].inspect}"
devices = node['media']['devices'].keys

devices.each do |mnt_device|
  # Obtain the mount point for the device from the devices Hash
  mount_point = node['media']['devices'][mnt_device]

  # Create the mount point directory
  directory mount_point do
    recursive true
    owner node['media']['user']
    group node['media']['group']
    mode 0755
    action :create
  end

  # Obtain the file system type using the helper. Refer to libraries/helper.rb
  # for the definition of the `get_file_system_type` method.
  file_system_type = Media::Helper.get_file_system_type(mnt_device)
  raise "Unable to find the file system type for device '#{mnt_device}'" \
    if file_system_type.nil?
  Chef::Log.info "File system type for '#{mnt_device}' is detected to be: " +
    file_system_type

  # If the devices follow /dev/disk/by-label/xxxx or /dev/disk/by-uuid/xxxx the
  # device type will be extracted and passed on to the mount resource. The
  # mount resource accepts the "label", "uuid", and "device" types.
  #
  match = mnt_device.match(/^\/dev\/disk\/by-(.*?)\/(.*)$/)
  unless match.nil?
    if ['uuid', 'label'].include?(match[1])
      mnt_device_type = match[1]
      mnt_device = match[2]
    else
      mnt_device_type = 'device'
    end
  end

  # Mount the device in the specified
  mount mount_point do
    device mnt_device
    device_type mnt_device_type
    fstype file_system_type
    action [:mount, :enable]
  end
end
