#
# Cookbook Name:: chef-zero
#
# Copyright 2013, Seth Vargo <sethvargo@gmail.com>
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

name             'chef-zero'
maintainer       'Seth Vargo'
maintainer_email 'sethvargo@gmail.com'
license          'apachev2'
description      'Installs Chef Zero on pre-chef-zero included Chef releases.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '2.0.1'

depends 'build-essential'
