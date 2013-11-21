#
# Cookbook Name:: cloudfoundry-ruby-runtime
# Attributes:: default
#
# Copyright 2012, ZephirWorks
# Copyright 2012, Trotter Cashion
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

default['cloudfoundry_ruby_runtime']['ruby18']['version']   = "1.8.7-p334"
default['cloudfoundry_ruby_runtime']['ruby19']['version']   = "1.9.2-p290"
default['cloudfoundry_ruby_runtime']['ruby193']['version']  = "1.9.3-p392"

default['cloudfoundry_ruby_runtime']['bundler_version'] = "1.1.3"