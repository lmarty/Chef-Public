#
# Cookbook Name:: akibanserver_test
# Recipe:: default
#
# Copyright 2012, Akiban Technologies
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

include_recipe 'akibanserver::default'

package "akiban-server" do
  action :nothing
end.run_action(:install)

akiban_connection = {:host => "localhost", :port => "15432"}

akiban_conn_args = "-h #{akiban_connection[:host]} -p #{akiban_connection[:port]} -t -q -A"

execute 'create-sample-data' do
  command %Q{psql #{akiban_conn_args} #{node['akibanserver_test']['schema']} <<EOF
    CREATE TABLE tv_chef (name VARCHAR(32) NOT NULL PRIMARY KEY);
    INSERT INTO tv_chef (name) VALUES ('Alison Holst');
    INSERT INTO tv_chef (name) VALUES ('Nigella Lawson');
    INSERT INTO tv_chef (name) VALUES ('Paula Deen');
EOF}
  not_if "echo 'SELECT count(name) FROM tv_chef' | psql #{akiban_conn_args} #{node['akibanserver_test']['schema']} | grep '^3$'"
end
