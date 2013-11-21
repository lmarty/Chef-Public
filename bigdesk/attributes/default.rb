#
# Author:: Sebastian Wendel
# Cookbook Name:: bigdesk
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

default[:bigdesk][:src_branch]          = "master"
default[:bigdesk][:src_mirror]          = "https://github.com/lukas-vlcek/bigdesk/tarball/#{node[:bigdesk][:src_branch]}"
default[:bigdesk][:install_path]        = "/var/www/bigdesk"
default[:bigdesk][:run_user]            = "www-data"
default[:bigdesk][:run_group]           = "www-data"
