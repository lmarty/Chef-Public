#
# Cookbook Name:: javamonitor
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
  Chef::Log.info(" Got URL #{url}")
  uri = URI(url)
  Chef::Log.info(" Got URI #{uri}")
  case type
  when :get
    req = Net::HTTP::Get.new(uri.request_uri)
  when :put
    req = Net::HTTP::Put.new(uri.request_uri)
  when :post
    req = Net::HTTP::Post.new(uri.request_uri)
  end

  Chef::Log.info(" Got req #{req}")
  http = Net::HTTP.new(uri.host, uri.port)

  Chef::Log.info("Calling #{req.method} on #{uri.request_uri} with data '#{data.to_json}', method #{req.class}")

  response = http.request(req, data.nil? ? data : data.to_json)

  response.body.gsub("\n", " ")

  return response
end
