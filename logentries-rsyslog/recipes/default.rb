#
# Cookbook Name:: logentries-rsyslog
# Recipe:: default
#
# Copyright 2013, HipSnip Ltd.
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

# Make sure a Token has been set
# @TODO: Better ways to Error out in Chef?
raise 'You have to set a Logentries Token in the attribute [:logentries][:token]' if node['logentries']['token'].empty?

include_recipe "rsyslog::default"

if node['logentries']['enable_tls']
  package 'rsyslog-gnutls' do
    action :install
  end

  cookbook_file '/etc/syslog.logentries.crt' do
    source   'logentries.crt'
    mode     0644
  end
end

# Add logentries to all syslog entries for now
template "/etc/rsyslog.d/10-logentries.conf" do
  source "rsyslog-main.erb"
  mode "0644"
  variables(
    :port => node['logentries']['enable_tls'] ? 20000 : 10000
  )
  notifies :restart, "service[rsyslog]"
end