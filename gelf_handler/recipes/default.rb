#
# Copyright Peter Donald
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

if node['chef_client']['handler']['gelf']['host']
  include_recipe 'chef_handler'

  chef_gem 'gelf'

  cookbook_file "#{Chef::Config[:file_cache_path]}/chef_gelf_handler.rb" do
    source 'chef_gelf_handler.rb'
    if node['platform'] != 'windows'
      mode '0600'
    end
  end

  chef_handler 'Chef::GELF::Handler' do
    source "#{Chef::Config[:file_cache_path]}/chef_gelf_handler.rb"
    arguments :host => node['chef_client']['handler']['gelf']['host'],
              :port => node['chef_client']['handler']['gelf']['port'],
              :facility => node['chef_client']['handler']['gelf']['facility'],
              :report_host => node['chef_client']['handler']['gelf']['report_host'],
              :blacklist => node['chef_client']['handler']['gelf']['blacklist'].to_hash

    action :enable
    supports :exception => true, :report => true
  end
end
