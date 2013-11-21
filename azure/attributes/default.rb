#
# Cookbook Name:: azure
# Attribute:: default
#
# Copyright (C) 2013 Panagiotis Papadomitsos
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

# For Redhat-based distributions - define your own!
default['azure']['rpm']['url']                          = nil
default['azure']['rpm']['checksum']                     = nil

# For the OHAI plugin
default['azure']['ohai']['override_embedded']           = true
default['azure']['ohai']['cleanup_old_versions']        = true

# Agent configuration - y enables, n disables (apparently :))
default['azure']['agent']['provisioning']               = 'y'
default['azure']['agent']['delete_root_password']       = 'y'
default['azure']['agent']['regenerate_ssh_key']         = 'y'
default['azure']['agent']['ssh_key_type']               = 'rsa' # Valid values are: rsa, dsa, ecdsa
default['azure']['agent']['monitor_hostname']           = 'y'

default['azure']['agent']['resource_disk_format']       = 'y'
default['azure']['agent']['resource_disk_filesystem']   = 'ext4'
default['azure']['agent']['resource_disk_mountpoint']   = '/mnt/resource'
default['azure']['agent']['resource_disk_swap']         = 'y'
default['azure']['agent']['resource_disk_swap_size']    = 4096

default['azure']['agent']['verbose_logs']               = 'n'
