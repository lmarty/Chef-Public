case node[:platform]
when "redhat","centos","fedora","suse"
  php5_dev = "php5-devel" 
when "ubuntu","debian"
  php5_dev = "php5-dev" 
else
  php5_dev = "php5-dev" 
end

package "#{php5_dev}" do
  action :upgrade
end

remote_file "#{Chef::Config[:file_cache_path]}/eaccelerator.tar.bz2" do
  checksum node[:php][:eaccelerator][:checksum]
  source node[:php][:eaccelerator][:url]
  mode "0644"
end

bash "build eAccelerator" do
  cwd "#{Chef::Config[:file_cache_path]}"
  code <<-EOH
mkdir eaccelerator
cd eaccelerator
tar --strip-components 1 -xjf #{Chef::Config[:file_cache_path]}/eaccelerator.tar.bz2
phpize
./configure
make
make install
cd ..
rm -rf eaccelerator
EOH
  action :nothing
end

directory "#{node[:php][:eaccelerator][:cache_dir]}" do
  owner node[:apache][:user]
  group node[:apache][:group]
  mode "0755"
  action :create
end

template "#{node[:php][:conf_dir]}/eaccelerator.ini" do
  source "eaccelerator.ini.erb"
  owner  "root"
  group  "root"
  mode   "0644"
  backup false
  notifies :run, resources(:bash => "build eAccelerator"), :immediately
end
