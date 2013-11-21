#
# Author:: Greg Fitzgerald <greg@gregf.org>
# Copyright:: Copyright (c) 2012, Opscode, Inc.
# License:: Apache License, Version 2.0
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

pkgs = case node['platform_family']
when 'rhel'
  %w(file-devel gcc make)
else
  %w(libncursesw5-dev libmagic-dev gcc make)
end

pkgs.each do |pkg|
  package pkg
end

tar_name = "vifm-#{node['vifm']['version']}"
remote_file "#{Chef::Config['file_cache_path']}/#{tar_name}.tar.bz2" do
  source "http://downloads.sourceforge.net/vifm/#{tar_name}.tar.bz2"
  checksum node['vifm']['checksum']
  notifies :run, 'bash[install_vifm]', :immediately
end

bash 'install_vifm' do
  user 'root'
  cwd Chef::Config['file_cache_path']
  code <<-EOH
      tar -xvjf #{tar_name}.tar.bz2
      (cd #{tar_name} && ./configure && make && make install)
    EOH
  action :nothing
end
