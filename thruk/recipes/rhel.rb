# for mod_fcgid
include_recipe "yum::epel"

major = node['platform_version'].to_i
machine = node['kernel']['machine']
platform_family = node['platform_family']

remote_file "#{Chef::Config[:file_cache_path]}/thruk-#{node['thruk']['version']}.#{platform_family}#{major}.#{machine}.rpm" do
  action :create_if_missing
  source "http://www.thruk.org/files/pkg/v#{node['thruk']['version']}/#{platform_family}#{major}/#{machine}/thruk-#{node['thruk']['version']}.#{platform_family}#{major}.#{machine}.rpm"
  backup false
  not_if "rpm -qa | grep -q '^thruk-#{node['thruk']['version']}'"
  notifies :install, "rpm_package[thruk]", :immediately
end

rpm_package "thruk" do
  source "#{Chef::Config[:file_cache_path]}/thruk-#{node['thruk']['version']}.#{platform_family}#{major}.#{machine}.rpm"
  options "--nodeps"
  action :nothing
end

file "thruk-cleanup" do
  path "#{Chef::Config[:file_cache_path]}/thruk-#{node['thruk']['version']}.#{platform_family}#{major}.#{machine}.rpm"
  action :delete
end
