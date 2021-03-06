#
# Cookbook Name:: wait
# Resource:: until
# Copyright (C) 2012 Justin Witrick
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#      http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# 

action :run do

  command = new_resource.command
  message = new_resource.message
  wait_interval = new_resource.wait_interval

  ruby_block new_resource.name do
    block do
      until system(command) do
        Chef::Log.info message
        sleep wait_interval
      end
    end
  end
  new_resource.updated_by_last_action(true)
end

# vim: ai et ts=2 sts=2 sw=2 ft=ruby
