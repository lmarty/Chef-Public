#
# Cookbook Name:: charon
# Recipe:: default
#
# Copyright 2012, Smashrun, Inc.
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
log("begin charon") { level :debug }
log("running charon") { level :info }

case "#{node[:kernel][:os_info][:version]}"
  when "5.2.3790"
    log("Charon currently only ferries Windows 2008 machines to the Azure skies across the river Styx.") { level :info }
    log("Seriously, if you are running MSSQL 2008+ on Windows 2003 just bite the bullet and upgrade your OS.") { level :info }
  when /^6\.*/
    include_recipe "charon::dotnet4fx"
    include_recipe "charon::datasyncprereqs"
    log("Microsoft has not created silent install functionality for SQL Azure Data Sync yet.") { level :info }    
    log("Once they do, this cookbook will be updated to include that functionality.") { level :info }    
    log("For now, all it does is install the pre-requisites and then download the SQL Data Sync bits.") { level :info }    
    include_recipe "charon::datasync"
    #include_recipe "charon::datasyncservice-control"
end

log("end charon") { level :info }
