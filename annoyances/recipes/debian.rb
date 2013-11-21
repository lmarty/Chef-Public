#
# Cookbook Name:: annoyances
# Recipe:: debian
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

#freshen up the apt repository, but not conflicting with the apt recipe
execute "apt-get update" do
  command "apt-get update"
  ignore_failure true
end.run_action(:run)

#turn off services
%w{'apparmor', 'whoopsie'}.each do |svc|
  service svc do
    action [:stop,:disable]
    ignore_failure true
  end
end

#turn off byobu
file "/etc/profile.d/Z98-byobu" do
  action :delete
  not_if do
    node.recipe?("byobu")
  end
end

%w{popularity-contest unity-lens-shopping whoopsie}.each do |pkg|
  package pkg do
    action :purge
    ignore_failure true
  end
end
