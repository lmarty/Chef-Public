#
# Cookbook Name:: javamonitor
# Provider:: application
#
# Author:: Jedrzej Sobanski (<jsobanski@lgi.com>)
#
# Copyright 2013, Liberty Global
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

require 'net/http'
require 'json'

def rest_call(path, data = nil, type = :get)
  url = "#{@new_resource.javamonitor_base_url}#{path}"
  if url.index( "?" ) then
    url << "&pw=#{@new_resource.javamonitor_password}"
  else
    url << "?pw=#{@new_resource.javamonitor_password}"
  end 
  uri = URI(url)
  case type
  when :get
    req = Net::HTTP::Get.new(uri.request_uri)
  when :put
    req = Net::HTTP::Put.new(uri.request_uri)
  when :post
    req = Net::HTTP::Post.new(uri.request_uri)
  end 

  http = Net::HTTP.new(uri.host, uri.port)

  Chef::Log.info("Calling #{req.method} on #{uri.request_uri} with data '#{data.to_json}', method #{req.class}")

  response = http.request(req, data.nil? ? data : data.to_json)

  response.body.gsub!("\n", " ")

  return response
end

# Tells if an application with the given name exists in JavaMonitor
def is_configured( app_name )
  rest_call("/admin/info?type=app&name=#{app_name}").code.to_i != 404
end

def configured_instances( app_name )
  JSON.parse rest_call( "/admin/info?type=app&info=full&name=#{app_name}" ).body
end

def full_app_config( app_name, path, output_path, additional_settings)
  Hash[
    "id" => app_name,
    "type" => "MApplication", 
    "macPath" => path,
    "unixPath" => path,
    "macOutputPath" => output_path,
    "unixOutputPath" => output_path
  ].merge( additional_settings )
end

def all_host_names
  JSON.parse(rest_call( "/ra/mHosts.json" ).body).map{ |host_config| host_config["name"]}
end

def synchronize_instances 
  all_hosts = all_host_names

  # Ensure all required hosts exist
  @new_resource.instances.each do |ins|
    raise "Host not found #{ins["host"]}" unless all_hosts.index( ins["host"] )
  end

  all_hosts.each do |host|
    expected_instances = @new_resource.instances.select{|ins| ins["host"] == host}
    synchronize_instances_on_host( @new_resource.name, host, expected_instances )
  end
end

def instances_on_host( host )
  configured_instances( @new_resource.name ).select{ |ins| ins["host"] == host }
end

def synchronize_instances_on_host( app_name, host, instances )
  base_url = @new_resource.javamonitor_base_url
  password = @new_resource.javamonitor_password

  for i in 1..(instances.size - instances_on_host(host).size) do
    javamonitor_instance app_name do
      name app_name
      host host
      javamonitor_base_url base_url
      javamonitor_password password
      action :create
    end
  end

  instances_on_host(host)[instances.size..-1].to_a.each do |ins|
    javamonitor_instance app_name do
      name app_name
      id ins["id"].to_i
      host host
      javamonitor_base_url base_url
      javamonitor_password password
      action :delete
    end
  end
end

action :create do
  application_settings_message = full_app_config( @new_resource.name, @new_resource.path, @new_resource.output_path, @new_resource.settings )
  requires_restart = false

  if is_configured( @new_resource.name ) then

    # check if anything has changed and if yes then restart the app
    current_config = JSON.parse( rest_call( "/ra/mApplications/#{@new_resource.name}.json" ).body )

    ["macPath", "unixPath", "macOutputPath", "unixOutputPath", "additionalArgs"].each do |config_option|
      current_val = current_config[config_option]
      new_val = application_settings_message[config_option]
      if current_val != new_val
        requires_restart = true
      end
    end

    application_settings_message.each_pair do |key, value|
      current_value = current_config[key]
    end

    # set new config values
    rest_call( "/ra/mApplications/#{@new_resource.name}.json", application_settings_message, :put )
  else
    rest_call( "/ra/mApplications.json", application_settings_message, :post )
  end


 Chef::Log.info("For #{@new_resource.name} have #{@new_resource.scheduled}")

  if @new_resource.scheduled then
    rest_call( "/admin/turnScheduledOn?type=app&info=full&name=#{@new_resource.name}" )
  else
    rest_call( "/admin/turnScheduledOff?type=app&info=full&name=#{@new_resource.name}" )
  end

  synchronize_instances

  if requires_restart then
    Chef::Log.debug(" Will restart for #{@new_resource}")
    base_url = @new_resource.javamonitor_base_url
    password = @new_resource.javamonitor_password
    javamonitor_application @new_resource.name do
      javamonitor_base_url base_url
      javamonitor_password password
      action :restart
    end

#    s.run_action :restart
  end
end

action :restart do
  base_url = @new_resource.javamonitor_base_url
  password = @new_resource.javamonitor_password
  configured_instances( @new_resource.name ).select{|ins| ins["state"] == "ALIVE"}.each do |ins|
 #   Chef::Log.info( "Restart is required for #{@new_resource.name}, but it's not implemented. Restart it manually" )
    javamonitor_instance @new_resource.name do
      id ins["id"].to_i
      host ins["host"]
      javamonitor_base_url base_url
      javamonitor_password password
      action :restart
    end
#    s.run_action :restart
  end
end
