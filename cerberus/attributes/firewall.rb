#
# Cookbook Name:: cerberus
# Attributes:: firewall
#
# Copyright 2010, Smashrun, Inc.
# Author:: Steven Craig <support@smashrun.com>
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

# for reference, this is an example of the JSON inside my chef-server data bags:

# inside databag firewall_rules:
# {"name":"nrpe","protocol":"tcp","id":"9999","permit":"enabled","description":"nrpe monitoring (tcp 9999)"}
#
# inside databag ip_permit:
# {"netmask":"/32","comment":"user workstation","fqdn":"hostname.domain.com","ipaddress":"192.168.0.1","id":"hostname","owner":"userid"}

# these are standard
default[:firewall][:author_name] = "Steve Craig"
default[:firewall][:author_email] = "support@smashrun.com"

# this cookbook shows up on my linux machines due to overlap with rsync
# wrap these attributes in a case so they don't pushed to linux machines (no need)
case node[:platform]
  when "windows"
  default[:firewall][:tempdir] = Chef::Config[:file_cache_path].gsub(::File::SEPARATOR, ::File::ALT_SEPARATOR)
  default[:firewall][:servicestatus] = "start"

  default['firewall']['gem'] = [
    { :name => 'json', :version => '1.8.0' }
    ]

  default['firewall']['jsonconf'] = "#{node[:firewall][:tempdir]}\\firewall"

  default[:firewall][:exception] = [
    { :name => 'cloudfront', :range => '54.230.0.0/16,54.239.128.0/18,54.240.128.0/18,204.246.164.0/22,204.246.168.0/22,204.246.174.0/23,204.246.176.0/20,205.251.192.0/19,205.251.249.0/24,205.251.250.0/23,205.251.252.0/23,205.251.254.0/24,216.137.32.0/19' },
    { :name => 'cloudflare', :range => '204.93.240.0/24,204.93.177.0/24,199.27.128.0/21,173.245.48.0/20,103.21.244.0/22,103.22.200.0/22,103.31.4.0/22,141.101.64.0/18,108.162.192.0/18,190.93.240.0/20,188.114.96.0/20,197.234.240.0/22,198.41.128.0/17,162.158.0.0/15' },
    { :name => 'facebook', :range => '31.13.24.0/21,31.13.64.0/18,66.220.144.0/20,69.63.176.0/20,69.171.224.0/19,74.119.76.0/22,103.4.96.0/22,173.252.64.0/18,204.15.20.0/22' },
    { :name => 'twitter', :range => '199.96.56.0/21,199.96.56.0/24,199.96.57.0/24,199.16.156.0/22,199.59.148.0/22,192.133.76.0/22,192.133.76.0/23,199.96.59.0/24,199.96.58.0/24,199.96.63.0/24' }
    ]

  case "#{node[:kernel][:os_info][:version]}"
  when "5.2.3790"
    default[:firewall][:deploydir] = "#{node[:kernel][:os_info][:windows_directory]}\\inf"
    default[:firewall][:basefw] = "netfw.inf"
    default[:firewall][:basefw_template] = "#{node[:firewall][:basefw]}-on.erb"
    default[:firewall][:servicename] = "SharedAccess"
    default[:firewall][:logging] = "false"
  when /^6\.*/
    default[:firewall][:servicename] = "MpsSvc"
    default[:firewall][:logging] = "true"
  end
end
