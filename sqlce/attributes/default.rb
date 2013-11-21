#
# Cookbook Name:: sqlce
# Attribute:: default
#
# Copyright (C) 2013 Joe Fitzgerald
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

if kernel['machine'] =~ /x86_64/
  default['sqlce']['4.0']['url']          = "http://download.microsoft.com/download/F/F/D/FFDF76E3-9E55-41DA-A750-1798B971936C/ENU/SSCERuntime_x64-ENU.exe"
  default['sqlce']['4.0']['checksum']     = "29e5ff4b478cd6709ac2a0d4a5e065ccec14e5b7b972b6afc852b498c03c40d0"
  default['sqlce']['4.0']['package_name'] = "Microsoft SQL Server Compact 4.0 SP1 x64 ENU"
else
  default['sqlce']['4.0']['url']          = "http://download.microsoft.com/download/F/F/D/FFDF76E3-9E55-41DA-A750-1798B971936C/ENU/SSCERuntime_x86-ENU.exe"
  default['sqlce']['4.0']['checksum']     = "eb463c0fededf177c9c28a5926d98b1bac957612679e3d4f0e9ad5ada10824e7"
  default['sqlce']['4.0']['package_name'] = "Microsoft SQL Server Compact 4.0 SP1 ENU"
end

default['sqlce']['4.0']['home']    = "#{ENV['SYSTEMDRIVE']}\\Program Files\\Microsoft SQL Server Compact Edition\\v4.0"