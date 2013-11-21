#
# Author:: Steve Craig <support@smashrun.com>
# Cookbook Name:: visualstudio
# Recipe:: default
#
# Copyright 2013, Smashrun, Inc.
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

log("begin visualstudio") { level :debug }
log("running visualstudio") { level :info }

if node[:platform] == "windows"

  if node['vs']['version'].to_f >= 11.0
    begin
    include_recipe "charon::dotnet45fx"
    rescue Chef::Exceptions::RecipeNotFound
      Chef::Log.warn "Could not find charon::dotnet45fx prerequisite!"
      Chef::Log.warn "Ensure you install Microsoft .Net 4.5 before Visual Studio 2012!"
    end
  end

  ###
  ### one recipe per visual studio version should work well
  ### set attribute for the visual studio version preference
  ###
  begin
  include_recipe "visualstudio::vs#{node['vs']['version']}"
  rescue Chef::Exceptions::RecipeNotFound
    Chef::Log.warn "Could not find visualstudio::vs$version recipe!"
    Chef::Log.warn "Ensure your default['vs']['version'] setting is valid!"
  end

end

log("end visualstudio") { level :info }
