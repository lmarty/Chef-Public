#
# Cookbook Name:: kvm
# recipe:: host-tuning
# Author:: Guilhem Lettron <guilhem.lettron@youscribe.com>
#
# Copyright 2012, Societe Publica.
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

include_recipe "kvm::default"

node[:kvm][:host][:tuning][:packages].each do |pkg|
  package pkg do
    action :install
  end
end


## Disable swapping when processor is INTEL with EPT instructions
# EPT doen't update "last access" in memory.
# In this case, Linux can put in swap a very used page.
# This has been fixed in 3.6 and backport on 3.5
if node['cpu']["0"]['flags'].include?("ept") and node['kernel']['release'] < "3.5"
  include_recipe "sysctl"

  sysctl "vm.swappiness" do
    value "0"
    action :set
  end
end

## Include some useful modules
case node[:platform]
when 'debian'
  include_recipe "modules"

  # vhost_net enhance networking performance.
  # libvirt detect and use it when module is loaded.
  modules "vhost_net"
  # The module is set to load in /etc/default/qemu-kvm instead in Ubuntu
when 'centos', 'redhat', 'scientific'
  # vhost_net installed by default
  # https://access.redhat.com/knowledge/docs/en-US/Red_Hat_Enterprise_Linux/6/html/Virtualization_Host_Configuration_and_Guest_Installation_Guide/ch11s02.html
end


#include_recipe "sysfs"
#sysfs "Tuning ondemand cpufreq governor" do
#  name "devices/system/cpu/cpufreq/ondemand/sampling_down_factor"
#  value "100"
#end

## Don't change the cpu frequency.
# clock drift (in some cases)
# Drop performances http://lists.gnu.org/archive/html/qemu-devel/2012-03/msg00842.html
node.default["cpu"]["governor"] = "performance"
include_recipe "cpu"

# enable/disable ksm. only works on ubuntu so far
case node[:platform]
when 'ubuntu'
  service "qemu-kvm" do
    action :nothing
    supports :restart => true
  end

  template "/etc/default/qemu-kvm" do
    source "default.qemu-kvm.erb"
    owner "root"
    group "root"
    mode 00644
    notifies :restart, "service[qemu-kvm]"
  end
end

include_recipe "sysfs"
sysfs "Enable transparent huge pages" do
  name "kernel/mm/transparent_hugepage/enabled"
  value "always"
  only_if do File.exists?("/sys/kernel/mm/transparent_hugepage/enabled") end
end

