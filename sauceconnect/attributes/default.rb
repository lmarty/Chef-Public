#
# Cookbook Name:: sauceconnect
# Attributes:: default
#
# Copyright 2012-2013, SecondMarket Labs, LLC
# Copyright 2013, Opscode, Inc.
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

# You can choose 'latest' as version, but keep in mind that whenever Saucelabs does a new release, your proxy will restart!
default['sauceconnect']['server']['version']='3.0-r28'
default['sauceconnect']['server']['download_url']='http://saucelabs.com/downloads'
default['sauceconnect']['server']['zipfile']="Sauce-Connect-#{node['sauceconnect']['server']['version']}.zip"
default['sauceconnect']['server']['install_dir']='/opt/sauceconnect'
default['sauceconnect']['server']['user']='sauceprx'
default['sauceconnect']['server']['log_file']="#{node['sauceconnect']['server']['install_dir']}/sauce_connect.log"

# Typically overridden in the role
default['sauceconnect']['server']['api_user']=''
default['sauceconnect']['server']['api_key']=''
