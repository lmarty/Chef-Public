#
# Cookbook Name:: cookbook_pusher
# Recipe:: default
#
# Copyright 2013, computerlyrik
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

path = "/cookbook_pusher"
directory path

#opscode key
template "#{path}/auth.pem" do
  variables ({ 
    :authkey => node['cookbook_pusher']['authkey']
  })
end

template "#{path}/knife.rb" do
  variables ({
    :path => path,
    :opscode_name => node['cookbook_pusher']['opscode_name']
  })
end

directory "#{path}/cookbooks"

############################       automagic

chef_gem "octokit"
require 'octokit'

include_recipe 'git'

Octokit.repositories(node['cookbook_pusher']['github_name']).each do |repo|
  if repo.name =~ /^chef-/
    
    if repo.fork 
      Chef::Log.info(repo.name + " is a fork, not publishing")
      next
    end
    
    name = repo.name[/chef-(.*)/,1]
    category = repo.description[/\|\ Category:\ (.*)$/,1]
    if category == nil 
      Chef::Log.warn("no category found for " + repo.name)
      next
    end
    
    Chef::Log.info("pushing " + repo.name + " as " + name + " into category " + category)

    git "#{path}/cookbooks/#{name}" do
      repository repo.clone_url
      action :sync
    end

    execute "knife cookbook site share #{name} #{category} -c #{path}/knife.rb" do
      action :nothing
      subscribes :run, resources(:git => "#{path}/cookbooks/#{name}")
      ignore_failure true
    end

  end
end

