#
# Cookbook Name:: doozer
# Attributes:: default
#
# Author:: John Bellone <john.bellone.jr@gmail.com>
#
# Copyright 2013, John Bellone, Jr.
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

default[:doozerd][:go_url] = 'github.com/ha/doozerd'
default[:doozerd][:install_prefix] = '/usr/local'
default[:doozerd][:user_group] = "root"
default[:doozerd][:user] = "root"
default[:doozerd][:run_options] = {
  :timeout => 5,
  :listen_port => 8046,
  :web_port => 8080,
  :name => 'local'
}

default[:doozer][:go_url] = 'github.com/ha/doozer'
default[:doozer][:install_prefix] = '/usr/local'
