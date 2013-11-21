#
# Cookbook Name:: freightyard-builder
# Recipe:: default
#
# Copyright 2012, Maciej Pasternacki
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

## Deps

include_recipe "freight"
include_recipe "perl"
package "gnupg"
gem_package "rake"

## User and group

group node['freightyard']['group']

user node['freightyard']['user'] do
  system true
  group node['freightyard']['group']
  home node['freightyard']['user_home_dir']
end

## Home directory & GPG key

directory node['freightyard']['user_home_dir'] do
  owner node['freightyard']['user']
  group node['freightyard']['group']
end

file "#{Chef::Config[:file_cache_path]}/freightyard_gpg_key_spec.txt" do
  content <<EOF
Key-Type: 1
Key-Length: 2048
Name-Real: #{node['freightyard']['gpg_real_name']}
Name-Email: #{node['freightyard']['gpg_email']}
Expire-Date: 0   
EOF
end

execute "generate-apt-gpg-key" do
  command "gpg --gen-key --batch < #{Chef::Config[:file_cache_path]}/freightyard_gpg_key_spec.txt"
  user node['freightyard']['user']
  group node['freightyard']['group']
  environment "HOME" => node['freightyard']['user_home_dir']
  not_if do
    File.exist? File.join(node['freightyard']['user_home_dir'], '.gnupg')
  end
end

ruby_block "save-apt-gpg-key" do
  block do
    node['freightyard']['public_gpg_key'] = `sudo -u #{node['freightyard']['user']} -H gpg --export --armor`
  end
end

## Root directory and configuration

directory node['freightyard']['root_dir'] do
  owner node['freightyard']['user']
  group node['freightyard']['group']
  mode '0755'
end

execute "configure-freight" do
  command <<EOF
freight init \\
    -c'#{node['freightyard']['root_dir']}/freight.conf' \\
    -g'#{node['freightyard']['gpg_email']}' \\
    --libdir='#{node['freightyard']['root_dir']}/lib' \\
    --cachedir='#{node['freightyard']['root_dir']}/cache' \\
    --archs='#{node['freightyard']['archs']}' \\
    --origin='#{node['freightyard']['origin']}' \\
    --label='#{node['freightyard']['label']}'
EOF
  user node['freightyard']['user']
  group node['freightyard']['group']
  creates "#{node['freightyard']['root_dir']}/freight.conf"
end

remote_file "/usr/local/bin/freightyard" do
  source "https://raw.github.com/3ofcoins/freightyard/#{node['freightyard']['script_revision']}/freightyard"
  mode '0755'
end
