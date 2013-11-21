#
# Cookbook Name:: cloudkick
# Recipe:: default
#
# Copyright 2010-2011, Opscode, Inc.
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

# Ensure consistent cloudkick credentials across the infrastructure.
# Override oauth credentials if search finds a data bag.
oauth = search(:cloudkick, "id:oauth").first
unless oauth.nil?
   node.override['cloudkick']['oauth_key'] = oauth['key']
   node.override['cloudkick']['oauth_secret'] = oauth['secret']
end

# Populate the conf file template using node attributes.
template "/etc/cloudkick.conf" do
  mode "0644"
  source "cloudkick.conf.erb"
  variables({
    :oauth_key => node['cloudkick']['oauth_key'],
    :oauth_secret => node['cloudkick']['oauth_secret'],
    :node_name => node['cloudkick']['node_name'],
    :local_plugins_path => node['cloudkick']['local_plugins_path'],
    # Combine any additional tags in node attributes with tags
    # generated automatically from run_list roles.
    :cloudkick_tags => (
           node.run_list.roles +
           node.cloudkick.additional_tags
         ).map{|t| t.downcase}.uniq.sort
  })
end

# Restart the cloudkick-agent iff the conf file changes.
service "cloudkick-agent" do
  action [ :enable, :start ]
  subscribes :restart, resources(:template => "/etc/cloudkick.conf")
end

