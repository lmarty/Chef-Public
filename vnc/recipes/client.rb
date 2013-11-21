#
# Cookbook Name:: vnc
# Recipe:: client
#
# Copyright 2011, Eric G. Wolfe
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

package "vnc-client" do
  case node[:platform]
    when "centos","redhat","fedora"
      if node[:platform_version].to_i <= 5
        package_name "vnc"
      elsif node[:platform_version].to_i >= 6
        package_name "tigervnc"
      end 
    when "debian","ubuntu"
      package_name "xtightvncviewer"
  end
  action :install
end
