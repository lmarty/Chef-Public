#
# Cookbook Name:: cloudfoundry_service
# Attributes:: tools
#
# Copyright 2013, ZephirWorks
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

default['cloudfoundry_service']['tools']['install'] = ['backup/manager']

default['cloudfoundry_service']['tools']['z_interval'] = 30
default['cloudfoundry_service']['tools']['log_level'] = 'info'

default['cloudfoundry_service']['tools']['backup']['enable'] = true
default['cloudfoundry_service']['tools']['backup']['max_days'] = 7
default['cloudfoundry_service']['tools']['backup']['unprovisioned_max_days'] = 10
default['cloudfoundry_service']['tools']['backup']['root'] = "/mnt/nfs/servicebackup"
default['cloudfoundry_service']['tools']['backup']['wakeup_interval'] = 43200
