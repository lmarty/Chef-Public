#
# Cookbook Name:: doozer
# Recipe:: doozer
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

install_prefix = node[:doozer][:install_prefix]
go = File.join(node[:go][:install_dir], 'go/bin/go')
go_url = node[:doozer][:go_url]

bash "install-doozer" do
  code "#{go} get #{go_url}"
  environment 'GOPATH' => install_prefix
  only_if {::File.directory?(install_prefix)}
end

bash "install-doozer-cli" do
  code "#{go} get #{go_url}/cmd/doozer"
  environment 'GOPATH' => install_prefix
  creates File.join(install_prefix, 'bin/doozer')
  only_if {::File.directory?(install_prefix)}
end
