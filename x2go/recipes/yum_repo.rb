#
# Cookbook Name:: x2go
# Recipe:: yum_repo
#
# Copyright 2013, Rilindo Foster
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

yum_key "x2go.key" do
  url "http://download.opensuse.org/repositories/X11:/RemoteDesktop:/x2go/RHEL_6/repodata/repomd.xml.key"
  action :add
end


yum_repository "x2go" do
  repo_name "x2go"
  description "x2go (replaces NX)"
  url "http://download.opensuse.org/repositories/X11:/RemoteDesktop:/x2go/RHEL_6"
  action :add
end