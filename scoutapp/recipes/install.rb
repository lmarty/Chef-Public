#
# Cookbook Name:: scoutapp
# Recipe:: install
#
# Copyright 2011, Efactures
#
# Apache 2.0 Licence
#

# dependency for building some gem
o = package "libxml2-dev" do
  action :nothing
end
o.run_action(:install)

p = package "libxslt1-dev" do
  action :nothing
end
p.run_action(:install)

# install scout
q = gem_package "scout" do
  action :nothing
end
q.run_action(:install)

# update scout
q = gem_package "scout" do
  action :nothing
end
q.run_action(:upgrade)


# Install scout api lib
r = gem_package "scout_scout" do
  action :nothing
end

r.run_action(:install)

# Install SystemTimer
s = gem_package "SystemTimer" do
  action :nothing
end

s.run_action(:install)

