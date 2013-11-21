# -*- coding: utf-8 -*-
#
# Cookbook Name:: gitosis
# Recipe:: default
#
# Copyright 2011, Maciej Pasternacki
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

include_recipe "git"
include_recipe "ssh_known_hosts"

package "gitosis"

HOME='/srv/gitosis'

directory HOME do
  mode "0750"
  owner "gitosis"
  group "gitosis"
end

file "#{HOME}/.gitconfig" do
  mode "0640"
  owner "gitosis"
  group "gitosis"
  content <<EOF
[user]
    email = gitosis@#{node[:fqdn]}
    name = Gitosis
EOF
end

group "gitosis" do
  members search(:users, "shell:[* TO *] AND groups:gitosis").map { |u|
    u["id"] }
  append true
end

execute "ssh-keygen -t dsa -f #{HOME}/.ssh/id_dsa -N '' -C gitosis" do
  creates "#{HOME}/.ssh/id_dsa"
  cwd HOME
  user "gitosis"
  group "gitosis"
end

execute "gitosis-init < #{HOME}/.ssh/id_dsa.pub" do
  creates "#{HOME}/.gitosis.conf"
  cwd HOME
  user "gitosis"
  group "gitosis"
  umask "027"
  environment({ "HOME" => HOME })
end

execute "git clone gitosis@#{node[:hostname]}:gitosis-admin.git admin" do
  user "gitosis"
  group "gitosis"
  environment "HOME" => HOME
  cwd HOME
  umask "027"
  not_if { File.directory? "#{HOME}/admin" }
end

execute "pull gitosis-admin" do
  command "git pull"
  cwd "#{HOME}/admin"
  user "gitosis"
  group "gitosis"
  environment "HOME" => HOME
end

directory "#{HOME}/admin/keydir" do
  owner "gitosis"
  group "gitosis"
end

repos_rw = {}
repos_ro = {}
search(:users, "gitosis_repos:[* TO *] OR gitosis_repos_ro:[* TO *]") do |u|
  for repo in u['gitosis_repos'].to_a
    repos_rw[repo] ||= []
    repos_rw[repo] << u['id']
  end
  for repo in u['gitosis_repos_ro'].to_a
    repos_ro[repo] ||= []
    repos_ro[repo] << u['id']
  end

  file "#{HOME}/admin/keydir/#{u['id']}.pub" do
    content u['ssh_keys']
    owner 'gitosis'
    group 'gitosis'
  end
end

template "#{HOME}/admin/gitosis.conf" do
  owner "gitosis"
  group "gitosis"
  variables :rw => repos_rw, :ro => repos_ro
end

bash "reconfigure gitosis" do
  code <<-EOF
    set -e -x
    git add keydir/*.pub gitosis.conf
    git commit -m 'reconfigure'
    git push
  EOF
  cwd "#{HOME}/admin"
  user "gitosis"
  group "gitosis"
  environment "HOME" => HOME
  not_if "git status |grep -q '^nothing to commit'", :user => "gitosis", :group => "gitosis", :cwd => "#{HOME}/admin"
end
