#
# Author:: Thorsten Klein (<cookbooks@perlwizard.de>)
# Cookbook Name:: windirstat
# Attribute:: default
#
# Copyright:: Copyright (c) 2013 Thorsten Klein
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

default[:windirstat][:url]          = "http://downloads.sourceforge.net/windirstat/windirstat1_1_2_setup.exe"
default[:windirstat][:checksum]     = "370a27a30ee57247faddeb1f99a83933247e07c8760a07ed82e451e1cb5e5cdd"
default[:windirstat][:package_name] = "WinDirStat 1.1.2"

default[:windirstat][:home]    = "#{ENV['SYSTEMDRIVE']}\\WinDirStat"
