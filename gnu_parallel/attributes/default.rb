#
# Cookbook Name:: gnu_parallel
# Attribute:: default
#
# Copyright 2011, Opscode, Inc.
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

default['gnu_parallel']['install_method'] = case node['platform']
                                            when "mac_os_x"
                                              'homebrew'
                                            when 'debian'
                                              'package'
                                            when 'ubuntu'
                                              node['platform_version'].to_f >= 12.10 ? 'package' : 'source'
                                            else
                                              'source'
                                            end

default['gnu_parallel']['url'] = 'http://ftp.gnu.org/gnu/parallel'
default['gnu_parallel']['version'] = '20130522'
default['gnu_parallel']['checksum'] = 'e9ea6fa2644e8504a85a518edb246783f2ccace58f21d101712b28bf781d7d2b'
default['gnu_parallel']['configure_options'] = []
