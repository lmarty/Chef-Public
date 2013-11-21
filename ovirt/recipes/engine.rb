#
# Cookbook Name:: ovirt
# Recipe:: engine
# Author:: Jason Cannon
#

include_recipe 'ovirt'

return unless node['ovirt']['supported_platforms'].include?(node['platform'])

package 'ovirt-engine' do
  action :install
  notifies :create, "template[#{node['ovirt']['answers_file']}]", :immediately
  notifies :run, 'bash[engine-setup]', :immediately
end

template node['ovirt']['answers_file'] do
  source 'answers.erb'
end
  
bash 'engine-setup' do
  user 'root'
  path ['/usr/bin', '/bin', '/sbin', '/usr/sbin']
  code <<-EOH
    yes 'Yes' | engine-setup --config-append=#{node['ovirt']['answers_file']}
  EOH
  notifies :restart, 'service[ovirt-engine]'
  action :nothing
end

service 'ovirt-engine' do
  action [ :enable, :start ]
  supports :restart => true, :status => true
end
