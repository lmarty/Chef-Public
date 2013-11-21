#
# Author:: Sebastian Wendel
# Cookbook Name:: chef-elasticsearch-head
# Attribute:: default
#
# Copyright 2012, SourceIndex IT-Services
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

default[:elastichead][:src_branch]          = "master"
default[:elastichead][:src_mirror]          = "https://github.com/mobz/elasticsearch-head/tarball/#{node[:elastichead][:src_branch]}"
default[:elastichead][:install_path]        = "/var/www/elastichead"
default[:elastichead][:run_user]            = "www-data"
default[:elastichead][:run_group]           = "www-data"