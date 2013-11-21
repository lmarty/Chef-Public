#
# Cookbook Name:: graylog2
# Recipe:: unicorn
#
# Copyright 2010, Medidata Solutions Inc.
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

# Install Graylog2 web interface
include_recipe "graylog2::web_interface"

# Install gem dependencies
rbenv_gem "unicorn" do
	ruby_version "#{node.graylog2.ruby_version}"
end

# Create general.yml
template "#{node[:graylog2][:basedir]}/web/config/unicorn.rb" do
  owner "nobody"
  group "nogroup"
  mode 0644
end

bash "graylog2 start unicorn" do
  cwd "#{node[:graylog2][:basedir]}/web"
  code "source /etc/profile.d/rbenv.sh && unicorn -p #{node.graylog2.web_interface.listen_port} -c ./config/unicorn.rb"
end