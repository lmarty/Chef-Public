#
# Cookbook Name:: incron
# Recipe:: default
#

package "incron" do
  action :install
end

service "incrond" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end
