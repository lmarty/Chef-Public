#
# Cookbook Name:: libvirt
# Recipe:: default
#
# Copyright 2009, Webtrends
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

include_recipe "apparmor"

package "libvirt-bin"

service "libvirt" do
  service_name "libvirt-bin"
  action [ :enable, :start ]
  supports [ :restart, :reload, :status ]
end

template "/etc/default/libvirt-bin" do
	source "libvirt-bin.default.erb"
	mode 0644
	owner "root"
	group "root"
  variables :libvirtd_opts => node[:libvirt][:server][:opts]
  notifies :restart, resources(:service => "libvirt"), :delayed
end

template "/etc/libvirt/libvirtd.conf" do
	source "libvirtd.conf.erb"
	mode 0644
	owner "root"
	group "root"
  variables :unix_sock_group => node[:libvirt][:server][:sock][:group]
  notifies :reload, resources(:service => "libvirt"), :delayed
end

template "/etc/libvirt/qemu.conf" do
  source "qemu.conf.erb"
  mode 0644
  owner "root"
  group "root"
  variables(
    :vnc_listen => node[:libvirt][:server][:vnc_listen],
    :vnc_tls => node[:libvirt][:server][:auth_tls] ? 1 : 0,
    :vnc_tls_x509_verify => node[:libvirt][:server][:vnc_tls_verify]
  )
end

if node[:libvirt][:server][:auth_tls]
  directory "/etc/pki"
  directory "/etc/pki/CA"
  directory "/etc/pki/libvirt"
  directory "/etc/pki/libvirt/private"
  directory "/etc/pki/libvirt-vnc"

  remote_file "/etc/pki/CA/cacert.pem" do
    source "#{node[:libvirt][:ca]}.cer"
  end

  remote_file "/etc/pki/libvirt-vnc/ca-cert.pem" do
    source "#{node[:libvirt][:ca]}.cer"
  end

  remote_file "/etc/pki/libvirt/servercert.pem" do
    source "#{node[:fqdn]}.cer"
  end

  remote_file "/etc/pki/libvirt-vnc/server-cert.pem" do
    source "#{node[:fqdn]}.cer"
  end

  remote_file "/etc/pki/libvirt/private/serverkey.pem" do
    source "#{node[:fqdn]}.key"
    mode 0600
    owner "root"
    group "root"
  end

  remote_file "/etc/pki/libvirt-vnc/server-key.pem" do
    source "#{node[:fqdn]}.key"
    mode 0600
    owner "root"
    group "root"
  end

  remote_file "/etc/apparmor.d/usr.sbin.libvirtd" do
    source "usr.sbin.libvirtd"
    action value_for_platform(
      "ubuntu" => { "9.10" => :create, "default" => :nothing },
      "default" => :nothing
    )
    notifies :reload, resources(:service => "apparmor"), :delayed
  end

  remote_file "/etc/apparmor.d/abstractions/libvirt-qemu" do
    source "libvirt-qemu"
    action value_for_platform(
      "ubuntu" => { "9.10" => :create, "default" => :nothing },
      "default" => :nothing
    )
    notifies :reload, resources(:service => "apparmor"), :delayed
  end
end

