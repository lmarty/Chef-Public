#
# Cookbook Name:: gitolite-server
# Recipe:: default
#
# Copyright 2012, TNW-labs
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

tag("Gitolite server directory @ /srv/gitolite")

include_recipe "git"
include_recipe "ssh_known_hosts"

HOME='/srv/gitolite'

package "gitolite" do
        action :install
end

execute "Add user gitolite" do
  command "adduser --system --shell /bin/bash --gecos 'git version control' --group --disabled-password --home #{HOME}  gitolite"
  not_if { File.directory? "#{HOME}" }
end

group "gitolite" do
  members search(:users, "shell:[* TO *] AND groups:gitolite").map { |u|
    u["id"] }
  append true
end

execute "ssh-keygen -t rsa -f #{HOME}/.ssh/id_rsa -N '' -C gitolite" do
	creates "#{HOME}/.ssh/id_rsa"
	user "gitolite"
	group "gitolite"
	cwd "#{HOME}"
	environment "HOME" => "#{HOME}"
end

execute "cp #{HOME}/.ssh/id_rsa.pub #{HOME}/gitolite.pub" do
	user "gitolite"
        group "gitolite"
	creates "#{HOME}/gitolite.pub"
end


file "#{HOME}/.gitconfig" do
  mode "0640"
  owner "gitolite"
  group "gitolite"
  content <<EOF
[user]
    email = git@#{node[:fqdn]}
    name = git
EOF
end


execute "git clone git://github.com/sitaramc/gitolite" do
	user "gitolite"
	group "gitolite"
	cwd HOME
	environment "HOME" => HOME
	creates "#{HOME}/gitolite"
end

directory "#{HOME}/bin" do
	owner "gitolite"
	group "gitolite"
end

execute "gitolite/install -to #{HOME}/bin" do
	user "gitolite"
        group "gitolite"
        cwd HOME
        environment "HOME" => HOME
        creates "#{HOME}/.gitolite"
end

execute "#{HOME}/bin/gitolite setup -pk gitolite.pub" do
	user "gitolite"
        group "gitolite"
        cwd HOME
        environment "HOME" => HOME
        creates "#{HOME}/.gitolite"
end


execute "git clone gitolite@localhost:gitolite-admin" do
	creates "#{HOME}/gitolite-admin"
	user "gitolite"
	group "gitolite"
	cwd "#{HOME}"
	environment "HOME" => HOME
end

execute "git pull" do 
	user "gitolite"
	group "gitolite"
	cwd "#{HOME}/gitolite-admin"
	environment "HOME" => HOME
end


apache_key = data_bag_item('gitolite', 'key')

file "#{HOME}/gitolite-admin/keydir/apache.pub" do
	owner "gitolite"
        group "gitolite"
	content apache_key['key_pub']
	not_if { File.exists?( "#{HOME}/gitolite-admin/keydir/apache.pub" )}
end

 repos_rw = {}
 repos_ro = {}
 search(:users, "gitolite_repos:[* TO *] OR gitolite_repos_ro:[* TO *]") do |u|
   for repo in Array(u['gitolite_repos'])
     repos_rw[repo] ||= []
     repos_rw[repo] << u['id']
   end
   for repo in Array(u['gitolite_repos_ro'])
     repos_ro[repo] ||= []
     repos_ro[repo] << u['id']
   end

   file "#{HOME}/gitolite-admin/keydir/#{u['id']}.pub" do
     content u['ssh_keys']
     owner 'gitolite'
     group 'gitolite'
   end
 end

 template "#{HOME}/gitolite-admin/conf/gitolite.conf" do
   owner "gitolite"
   group "gitolite"
   variables :rw => repos_rw, :ro => repos_ro
 end

bash "reconfigure gitolite" do
   code <<-EOF
     set -e -x
     git add keydir/*.pub conf/gitolite.conf
     git commit -m 'reconfigure'
     git push 
   EOF
   cwd "#{HOME}/gitolite-admin/"
   user "gitolite"
   group "gitolite"
   environment "HOME" => HOME
   not_if "git status |grep -q '^nothing to commit'", :user => "gitolite", :group => "gitolite", :cwd => "#{HOME}/gitolite-admin/"
end

