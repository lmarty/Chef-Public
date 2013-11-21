#
# Cookbook Name:: el2centos 
# Attributes:: default
#
# Author:: Eric G. Wolfe <wolfe21@marshall.edu>
#
# Copyright 2012, Eric G. Wolfe
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
if node['kernel']['machine'] =~ /^(x|i[3456])86$/i
  machine_arch = "i386"
end
if node['kernel']['machine'] =~ /^(x86_|amd)64$/i
  machine_arch = "x86_64"
end

default['el2centos']['conversion_path'] = "#{Chef::Config['file_cache_path']}/el2centos"
default['el2centos']['base_url'] = "http://mirror.centos.org/centos/#{node['platform_version'].to_i}/os/#{machine_arch}"
default['el2centos']['centos_key'] = "#{node['el2centos']['base_url']}/RPM-GPG-KEY-CentOS-#{node['platform_version'].to_i}"

case node['platform_version'].to_i
when 5
  default['el2centos']['rpm_url'] = "#{node['el2centos']['base_url']}/CentOS/"
  default['el2centos']['rpms'] = [
    "centos-release-5-9.el5.centos.1.#{machine_arch}.rpm",
    "centos-release-notes-5.9-0.#{machine_arch}.rpm",
    "yum-3.2.22-40.el5.centos.noarch.rpm",
    "yum-updatesd-0.9-5.el5.noarch.rpm",
    "yum-fastestmirror-1.1.16-21.el5.centos.noarch.rpm"
  ]
  default['el2centos']['rpms2remove'] = [
    "redhat-release",
    "yum-rhn-plugin"
  ]
when 6
  default['el2centos']['rpm_url'] = "#{node['el2centos']['base_url']}/Packages/"
  default['el2centos']['rpms'] = [
    "centos-release-6-4.el6.centos.10.#{machine_arch}.rpm",
    "yum-3.2.29-40.el6.centos.noarch.rpm",
    "yum-utils-1.1.30-14.el6.noarch.rpm",
    "yum-plugin-fastestmirror-1.1.30-14.el6.noarch.rpm"
  ]
  default['el2centos']['rpms2remove'] = [
    "redhat-release-server-6Server",
    "yum-rhn-plugin",
    "rhn-check",
    "rhnsd",
    "rhn-setup",
    "rhn-setup-gnome"
  ]
end
