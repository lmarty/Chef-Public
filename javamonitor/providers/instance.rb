#
# Cookbook Name:: javamonitor
# Provider:: instance
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

def rest_call(path)
  url = "#{@new_resource.javamonitor_base_url}#{path}#{path.index( "?" ) ? "&" : "?"}pw=#{@new_resource.javamonitor_password}"

  uri = URI(url)
  req = Net::HTTP::Get.new(uri.request_uri)
  http = Net::HTTP.new(uri.host, uri.port)

  Chef::Log.debug("Making REST request #{url}")
  response = http.request(req)
  raise "Got error #{response.code}: #{response.body}" if response.code.to_i != 200

  return response
end

def get_instance_info
  rest_call("/admin/info?type=ins&name=#{@new_resource.name}-#{@new_resource.id}")
end

def wait_until(timeout = 5, &condition)
  sleep_time = 0.5
  timer = 0

  while ! yield
    sleep(sleep_time)
    timer += sleep_time
    raise "Condition timeout" if timer > timeout && ! yield
  end
end

def this_host_instances
  JSON.parse rest_call( "/admin/info?type=app&info=full&name=#{@new_resource.name}&host=#{@new_resource.host}" ).body.gsub("\n", " ")
end
 

action :create do
  Chef::Log.info("Creating a new instance of #{@new_resource.name}")
  rest_call( "/ra/mApplications/#{@new_resource.name}/addInstance?host=#{@new_resource.host}" )

  id = this_host_instances.last["id"].to_i
  host = @new_resource.host
  base_url = @new_resource.javamonitor_base_url
  password = @new_resource.javamonitor_password

  s = javamonitor_instance @new_resource.name do
    id id
    host host
    javamonitor_base_url base_url
    javamonitor_password password
    action :nothing
  end
  s.run_action :start
end

action :start do
  Chef::Log.info("Starting instance #{@new_resource.name}-#{@new_resource.id}")
  rest_call( "/admin/start?type=ins&name=#{@new_resource.name}-#{@new_resource.id}" )
end

action :delete do
  Chef::Log.info("Deleting an instance of #{@new_resource.name}-#{@new_resource.id}")
  run_action :stop
  rest_call( "/ra/mApplications/#{@new_resource.name}/deleteInstance?host=#{@new_resource.host}&id=#{@new_resource.id}" )
end

action :stop do
  Chef::Log.info("Stopping an instance of #{@new_resource.name}-#{@new_resource.id}")
  rest_call( "/admin/turnAutoRecoverOff?type=ins&name=#{@new_resource.name}-#{@new_resource.id}" )
  rest_call( "/admin/turnRefuseNewSessionsOn?type=ins&name=#{@new_resource.name}-#{@new_resource.id}" )
end

action :restart do
  inst_id = @new_resource.id
  app_name = @new_resource.name
  host = @new_resource.host
  identifier = "#{app_name}-#{inst_id}"

  Chef::Log.info("Restarting an instance of #{identifier} on #{host}" )

  rest_call( "/admin/stop?type=ins&name=#{identifier}" )
  wait_until {
    repl = JSON.parse rest_call( "/admin/info?type=ins&name=#{identifier}" ).body.gsub("\n", " ")
    repl[0]["state"] == "DEAD"
  }
  Chef::Log.info("Instance #{identifier} is stopped")

  rest_call( "/admin/start?type=ins&name=#{identifier}" )
  wait_until(60) {
    repl = JSON.parse rest_call( "/admin/info?type=ins&name=#{identifier}" ).body.gsub("\n", " ")
    repl[0]["state"] == "ALIVE"
  }
  Chef::Log.info("Instance #{identifier} is running")
end
