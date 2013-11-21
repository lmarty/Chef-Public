#
# Cookbook Name:: mailcatcher
# Recipe:: default
#
# Copyright 2013, Chendil Kumar Manoharan
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

execute "Install the dependant gcc-c++" do
 user "root"
 cwd "/tmp/"
 command "zypper -n --no-gpg-checks install -l gcc-c++" 
  action :run
end

execute "Install the dependant sqlite3-devel" do
 user "root"
 cwd "/tmp/"
 command " zypper -n --no-gpg-checks install -l sqlite3-devel" 
  action :run
end

execute "Install mailcatcher" do
 user "root"
 cwd "/tmp/"
 command "gem install mailcatcher --no-rdoc --no-ri --no-format-executable" 
  action :run
end
  
  execute "Start mailcatcher" do
 user "root"
 cwd "/tmp/"
 command "mailcatcher --ip=0.0.0.0" 
  action :run
end
  