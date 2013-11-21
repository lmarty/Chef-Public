major = node['platform_version'].to_i
machine = node['kernel']['machine']
platform_family = node['platform_family']

machine =  "amd64" if machine == "x86_64" 

%w{libcairo2 libcurl3 libfontconfig1 libfreetype6 libgd2-xpm libjpeg62 libmysqlclient16 libpng12-0 libxpm4 xvfb}.each do  |pkg|
  package pkg
end

remote_file "#{Chef::Config[:file_cache_path]}/thruk_#{node['thruk']['version']}_#{platform_family}#{major}_#{machine}.deb" do
  action :create_if_missing
  source "http://www.thruk.org/files/pkg/v#{node['thruk']['version']}/#{platform_family}#{major}/#{machine}/thruk_#{node['thruk']['version']}_#{platform_family}#{major}_#{machine}.deb"
  backup false
  not_if "dpkg-query -W thruk | grep -q '^thruk[[:blank:]]#{node['thruk']['version']}$'"
  notifies :install, "dpkg_package[thruk]", :immediately
end

dpkg_package "thruk" do
  source "#{Chef::Config[:file_cache_path]}/thruk_#{node['thruk']['version']}_#{platform_family}#{major}_#{machine}.deb"
  action :nothing
end

file "thruk-cleanup" do
  path "#{Chef::Config[:file_cache_path]}/thruk_#{node['thruk']['version']}_#{platform_family}#{major}_#{machine}.deb"
  action :delete
end
