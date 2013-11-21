#
# Cookbook Name:: npm_registry
#
# Copyright 2013 Cory Roloff
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

maintainer       'Cory Roloff'
license          'Apache 2.0'
description      'Installs and configures an NPM registry'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
name             'npm_registry'
version          '0.2.0'

recipe           'npm_registry', 'Installs and configures an NPM registry'

%w{git couchdb nodejs}.each do |cookbook|
  depends cookbook
end

%w{cron}.each do |cookbook|
  suggests cookbook
end

%w{ubuntu}.each do |os|
  supports os
end