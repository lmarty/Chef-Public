#
# Cookbook Name:: annoyances
# Recipe:: rhel
#
# Copyright 2012-2013, Opscode, Inc.
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

#delete any preexisting firewall rules
execute("iptables -F") { ignore_failure true }.run_action(:run)

#turn off SELinux
if Mixlib::ShellOut.new("getenforce").run_command.stdout != "Disabled\n" then
  execute("setenforce 0") { ignore_failure true }.run_action(:run)
end

#uninstall httpd
if Mixlib::ShellOut.new("rpm -q httpd").run_command.status.success? then
  execute "rpm --nodeps -e httpd" do
    ignore_failure true
    not_if do
      node.recipe?("apache2")
    end
  end
end

#remove any .bash_logout
file("/root/.bash_logout") { action :delete }

#disable the pile of desktop services that get turned on by default
%w{autofs avahi-daemon bluetooth cpuspeed cups gpm haldaemon messagebus}.each do |svc|
  service svc do
    action [:stop, :disable]
  end
end
