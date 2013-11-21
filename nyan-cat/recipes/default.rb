#
# Cookbook Name:: nyan-cat
# Recipe:: default
#
# Copyright 2008-2009, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
# implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#             

chef_gem "nyan-cat-chef-formatter"

append_if_no_line "nyan" do
  path  Chef::Config['config_file']
  line "gem 'nyan-cat-chef-formatter'"
end

append_if_no_line "nyan nyan" do
  path  Chef::Config['config_file']
  line "require 'nyan-cat-chef-formatter'"
end

append_if_no_line "nyan nyan nyan" do
  path  Chef::Config['config_file']
  line "log_level :fatal"
end

append_if_no_line "nyan nyan nyan nyan" do
  path  Chef::Config['config_file']
  line "formatter \"nyan\""
end

