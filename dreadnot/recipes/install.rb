# encoding: utf-8
#
# Cookbook Name:: dreadnot
# Recipe:: install
#
# Copyright 2013, ModCloth, Inc.
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

group node['dreadnot']['group'] do
  gid node['dreadnot']['gid']
end

user node['dreadnot']['user'] do
  gid node['dreadnot']['group']
  supports manage_home: true
  home node['dreadnot']['home']
  shell node['dreadnot']['shell']
end

template "#{node['dreadnot']['home']}/.bashrc" do
  source 'dotbashrc.sh.erb'
  owner node['dreadnot']['user']
  group node['dreadnot']['group']
  mode 0640
end

template "#{node['dreadnot']['home']}/.bash_profile" do
  source 'dotbash_profile.sh.erb'
  owner node['dreadnot']['user']
  group node['dreadnot']['group']
  mode 0640
end

if node['dreadnot']['install_nodejs'] && node['platform_family'] != 'smartos'
  include_recipe 'nodejs'
elsif node['platform_family'] == 'smartos'
  package 'nodejs 0.6.21' do
    package_name 'nodejs'
    version '0.6.21'
    action :nothing
  end

  package 'nodejs 0.10.4' do
    package_name 'nodejs'
    version '0.10.4'
    action :remove
    notifies :install, 'package[nodejs 0.6.21]'
  end
end

bash 'install dreadnot' do
  code 'npm install dreadnot'
  cwd node['dreadnot']['home']
  user node['dreadnot']['user']
  environment 'HOME' => node['dreadnot']['home']
  not_if do
    ::File.exists?("#{node['dreadnot']['home']}/node_modules/.bin/dreadnot")
  end
end

directory node['dreadnot']['instance_prefix'] do
  owner node['dreadnot']['user']
  group node['dreadnot']['group']
  mode 0750
end
