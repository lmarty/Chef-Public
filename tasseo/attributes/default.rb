#
# Author:: Dan Ryan <dan@crowdflower.com>
# Cookbook Name:: tasseo
# Attributes:: default
#
# Copyright 2012, CrowdFlower, Inc.
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

default[:tasseo][:home_dir]      = "/usr/local/lib/tasseo"
default[:tasseo][:dashboard_dir] = "#{node[:tasseo][:home_dir]}/public/d"
default[:tasseo][:log_dir]       = "/var/log/tasseo"
default[:tasseo][:user]          = "tasseo"
default[:tasseo][:run_state]     = :start
default[:tasseo][:port]          = 5000
default[:tasseo][:git_repo]      = "https://github.com/obfuscurity/tasseo.git"
default[:tasseo][:graphite_url]  = "localhost"
default[:tasseo][:graphite_auth] = "username:changeme"
default[:tasseo][:url]           = "tasseo.example.com"