
#
# Author:: Mat Davies (<ashmere@gmail.com>)
# Cookbook Name:: fusioninventory-agent
# Attribute:: default
#
# Copyright 2012
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


default['fusioninventory-agent']['conf_dir'] = '/etc/fusioninventory'
default['fusioninventory-agent']['server_url'] = 'http://www.example.com/glpi/plugins/fusioninventory/'
default['fusioninventory-agent']['no-ocsdeploy'] = '0'
default['fusioninventory-agent']['no-inventory'] = '0'
default['fusioninventory-agent']['no-printer'] = '0'
default['fusioninventory-agent']['no-software'] = '0'
default['fusioninventory-agent']['no-ssl-check'] = '1'
default['fusioninventory-agent']['no-wakeonlan'] = '0'
default['fusioninventory-agent']['no-snmpquery'] = '0'
default['fusioninventory-agent']['no-netdiscovery'] = '0'
default['fusioninventory-agent']['no-p2p'] = '0'
default['fusioninventory-agent']['tag'] = ""
default['fusioninventory-agent']['proxy'] = ""
default['fusioninventory-agent']['proxy_user'] = ""
default['fusioninventory-agent']['proxy_password'] = ""
default['fusioninventory-agent']['ca-cert-dir'] = ""
default['fusioninventory-agent']['ca-cert-file'] = ""
default['fusioninventory-agent']['no-httpd'] = '0'
default['fusioninventory-agent']['httpd-ip'] = ""
default['fusioninventory-agent']['httpd-port'] = '62354'
default['fusioninventory-agent']['httpd-trust'] = ""
default['fusioninventory-agent']['daemon'] = '1'
default['fusioninventory-agent']['lazy'] = '0'
default['fusioninventory-agent']['mode'] = 'daemon'
default['fusioninventory-agent']['service'] = 'fusioninventory-agent'
