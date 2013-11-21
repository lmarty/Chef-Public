#
# Cookbook Name:: mogilefs
# Definition:: mogilefs_database
#
# Author:: Jamie Winsor (<jamie@enmasse.com>)
#
# Copyright 2011, En Masse Entertainment, Inc.
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

define :mogilefs_database, :root_username => nil, :root_password => nil, :host => nil, :username => nil, :password => nil, :type => "MySQL" do
  require_recipe "mogilefs"

  execute "Initialize MogileFS database schema on #{params[:host]}" do
    command "mogdbsetup --dbrootuser=#{params[:root_username]} --dbrootpass=#{params[:root_password]} --dbhost=#{params[:host]} --dbname=#{params[:name]} --dbuser=#{params[:username]} --dbpassword=#{params[:password]} --type=#{params[:type]} --yes"
  end
end
