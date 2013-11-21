#
# Cookbook Name:: komodo-edit
# Recipe:: default
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


default['komodo-edit']['package_name'] = 'komodo-edit'
default['komodo-edit']['windows']['package_name'] = 'Komodo Editor'
default['komodo-edit']['windows']['url'] =
  'http://downloads.activestate.com/Komodo/releases/8.5.0/Komodo-Edit-8.5.0-13638.msi'
