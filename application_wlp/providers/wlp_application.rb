#
# Cookbook Name:: application_wlp
# Provider:: wlp_application
#
# (C) Copyright IBM Corporation 2013.
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

include Chef::Mixin::LanguageIncludeRecipe

action :before_compile do
  include_recipe "wlp"

  wlp_server new_resource.server_name do
    config (new_resource.server_config)
    action :create_if_missing
  end
end

action :before_deploy do

  create_application_xml_file

  add_application

end

# Add the new application include into the server.xml file
def add_application
    config = Liberty::Applications::Config.load(node, new_resource.server_name)
    config.include("${server.config.dir}/#{new_resource.application.name}.xml")
    if config.modified
      config.save()
    end
end

action :before_migrate do
end

action :before_symlink do
end

action :before_restart do
end

action :after_restart do
end

protected

def create_application_xml_file

    if !(new_resource.config)
      config = {
         "featureManager" => {
            "feature" => new_resource.features
         },
         "application" => {
            "name" => new_resource.application.name,
            "location" => "#{new_resource.application_location || (new_resource.path + '/current/' + IO::File.basename(new_resource.repository))}"
         }
      }
    else 
      config = new_resource.config
    end

    wlp_config "#{@utils.serversDirectory}/#{new_resource.server_name}/#{new_resource.application.name}.xml" do
      config config
    end

end

def load_current_resource
  @utils = Liberty::Utils.new(node)
end

