#
# Cookbook Name:: easyapache
# Recipe:: default
#
#   Copyright 2012, Derek Schultz
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#

yaml = node['easyapache']['yaml']

cookbook_file "/var/cpanel/easy/apache/profile/custom/#{yaml}" do
  source "#{yaml}"
  owner "root"
  group "root"
  mode "00644"
  action :create_if_missing
end

bash "easyapache build" do
  code <<-EOH
  /scripts/easyapache --profile=#{yaml} --build --output-syspkg-details
  EOH
end
