include_recipe "build-essential"

remote_file "#{Chef::Config[:file_cache_path]}/gflags-#{node['gflags']['archive']['version']}.tar.gz" do
  source    node['gflags']['archive']['url']
  checksum  node['gflags']['archive']['checksum']
  mode      "0644"
  action    :create_if_missing
end

execute "Extracting gflags #{node['gflags']['archive']['version']}" do
  cwd Chef::Config[:file_cache_path]
  command "tar -zxf gflags-#{node['gflags']['archive']['version']}.tar.gz"
  creates "#{Chef::Config[:file_cache_path]}/gflags-#{node['gflags']['archive']['version']}"
end

execute "Installing gflags #{node['gflags']['archive']['version']} archive" do
  cwd "#{Chef::Config[:file_cache_path]}/gflags-#{node['gflags']['archive']['version']}"
  command "./configure --prefix=#{node['gflags']['archive']['install_dir']} && make && make check && make install"
  creates "#{node['gflags']['archive']['install_dir']}/lib/gflags.so"
  action :run
  notifies :run, "execute[ldconfig]", :immediately
end

execute "ldconfig" do
  command "ldconfig"
  action :nothing
end
