#
# Cookbook Name:: komodo-edit
# Recipe:: ubuntu
#
# Copyright 2013, Rilindo Foster <rilindo.foster@monzell.com
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


include_recipe 'apt'

apt_repository 'komodo-edit' do
  uri 'http://ppa.launchpad.net/mystic-mirage/komodo-edit/ubuntu'
  distribution node['lsb']['codename']
  components %w(main)
  keyserver    'keyserver.ubuntu.com'
  key 'A7E2BCD2'
  action :add
end

package node['komodo-edit']['package_name'] 