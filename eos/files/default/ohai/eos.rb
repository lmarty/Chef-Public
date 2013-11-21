#
# Chef Cookbook   : eos
# File            : files/defaults/eos.rb
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
provides "eos"
provides "eos/version"

eos Mash.new unless eos
eos[:version] = Mash.new unless eos[:version]

begin
  cmd = "FastCli -c \"show version\""
  status, stdout, stderr = run_command(:command => cmd)
  lines = stdout.split("\n")

  eos[:version][:os_name] = lines.shift
  lines.each do |line|
    next if line.empty?

    k,v = line.split(':')
    if v.nil?
      Chef::Log.warn "Ohai eos version plugin - unparsable line 'line'"
    else
      k.downcase!
      k.gsub!(' ','_')
      eos[:version][k] = v.strip
    end
  end
rescue => e
    Chef::Log.warn "Ohai eos version plugin failed with '#{e}'"
end
