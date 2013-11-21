#
# Cookbook Name:: akibanserver
# Recipe:: setup_repos
#
# Copyright 2012, Akiban Technologies
#
# Apache License
#

if platform?(%w{debian ubuntu})
  include_recipe "apt"
end

# Adds the Akiban repo:
# deb http://software.akiban.com/apt-community/ lucid main
# TODO - Find package codenames
apt_repository "akiban-repo" do
  uri "http://akiban:Akiba1Inc@software.akiban.com/apt"
  distribution "lucid"
  components ["main"]
  keyserver "keyserver.ubuntu.com"
  key "0AA4244A"
  notifies :run, "execute[apt-get update]", :immediately
  action :add
end

if platform?(%w{centos redhat amazon scientific})
  distribution="EL"

  # Add the Akiban Repo
  filename = "/etc/yum.repos.d/akiban.repo"
  repoFile = "[akiban]" << "\n" <<
             "name=Akiban Technologies repository" << "\n" <<
             "baseurl=http://software.akiban.com/developer" << "\n" <<
             "enabled=1" << "\n" <<
             "gpgcheck=0" << "\n"
  File.open(filename, 'w') {|f| f.write(repoFile) }

  execute "yum clean all"
end
