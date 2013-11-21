#
# Chef Cookbook   : eos
# File            : library/default.rb
#    
# Copyright 2013 Arista Networks
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
  
def has_changed?(curres, newres)
  Chef::Log.debug "Checking: #{curres} is equal to #{newres}"
  return curres != newres && !newres.nil?
end

def run_command(command)
  Chef::Log.info "Running command: #{command}"
  command = Mixlib::ShellOut.new(command)
  command.run_command()
  return command.stdout
end
