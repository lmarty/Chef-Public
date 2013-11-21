# encoding: utf-8
execute 'Making lmctfy C++ via source' do
  cwd "#{Chef::Config[:file_cache_path]}/lmctfy"
  command "make -j #{node['cpu']['total']} liblmctfy.a"
  creates "#{Chef::Config[:file_cache_path]}/lmctfy/bin/liblmctfy.a"
  action :run
end

link "#{node['lmctfy']['install_dir']}/lib/liblmctfy.a" do
  to "#{Chef::Config[:file_cache_path]}/lmctfy/bin/liblmctfy.a"
  notifies :run, 'execute[ldconfig]', :immediately
end

execute 'ldconfig' do
  command 'ldconfig'
  action :nothing
end
