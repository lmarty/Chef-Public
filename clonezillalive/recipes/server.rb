#
# Cookbook Name:: clonezillalive
# Recipe:: server
#
# Copyright 2013, Arnold Krille for bcs kommunikationsloesungen
#                 <a.krille@b-c-s.de>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe('tftp::server')
tftpdir = node['tftp']['directory']

package "unzip"
package "syslinux"

node.default['nfs']['service']['portmap'] = 'rpcbind'
include_recipe('nfs::server')

remote_file "#{Chef::Config[:file_cache_path]}/clonezilla-live-2.1.2-43-i686-pae.zip" do
  source "http://sourceforge.net/projects/clonezilla/files/clonezilla_live_stable/2.1.2-43/clonezilla-live-2.1.2-43-i686-pae.zip/download"
  checksum "3ab39169a1fdbdc89e61b943e8a7f39374babd53"
  mode 00644
  not_if { ::File.exists?("#{Chef::Config[:file_cache_path]}/clonezilla-live-2.1.2-43-i686-pae.zip") }
end

['pxelinux.cfg', 'clonezilla'].each do |dir|
  directory "#{tftpdir}/#{dir}" do
    action :create
    mode 0755
  end
end

['pxelinux.0', 'vesamenu.c32'].each do |file|
  execute "place #{file}" do
    command "cp /usr/lib/syslinux/#{file} #{tftpdir}"
    creates "#{tftpdir}/#{file}"
  end
end

['default', 'clonezilla.cfg'].each do |file|
  template "#{tftpdir}/pxelinux.cfg/#{file}" do
    source "pxeconfig.cfg/#{file}.erb"
    mode 0755
    variables({
      :serverip => node['ipaddress'],
      #:x2gotce_base => x2gotce_base
    })
  end
end

bash "unpack_clonezilla" do
  user "root"
  cwd "#{tftpdir}/clonezilla"
  code "unzip -j #{Chef::Config[:file_cache_path]}/clonezilla-live-2.1.2-43-i686-pae.zip live/vmlinuz live/initrd.img live/filesystem.squashfs -d ."
  not_if { ::File.exists?("#{tftpdir}/clonezilla/vmlinuz") }
end

## nfs part
['clonezilla', 'clonezilla/disk'].each do |dir|
  directory "/media/#{dir}" do
    action :create
    mode 00755
    owner "root"
    group "root"
  end
end

nfs_export "/media/clonezilla" do
  network "*"
  writeable true
  sync false
  options ['no_root_squash', 'hide', 'nocrossmnt', 'no_subtree_check']
end

