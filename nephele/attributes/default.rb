#
# Author:: Steve Craig <support@smashrun.com>
# Cookbook Name:: nephele
# Attributes:: default
#
# Copyright 2012, Smashrun, Inc.
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

default[:nephele][:author_name] = "Steve Craig"
default[:nephele][:author_email] = "support@smashrun.com"

# http://rubygems.org/gems/win32-process
# http://rubygems.org/gems/sys-proctable

default[:nephele][:gem] = [
  { :name => 'fog', :version => '1.6.0' }
  ]

default[:nephele][:tempdir] = Chef::Config[:file_cache_path].gsub(::File::SEPARATOR, ::File::ALT_SEPARATOR)

