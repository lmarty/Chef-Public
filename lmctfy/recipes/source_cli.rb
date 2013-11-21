# encoding: utf-8
execute 'Making lmctfy CLI via source' do
  cwd "#{Chef::Config[:file_cache_path]}/lmctfy"
  command "make -j #{node['cpu']['total']} lmctfy"
  creates "#{Chef::Config[:file_cache_path]}/lmctfy/bin/lmctfy/cli/lmctfy"
  action :run
end

link "#{node['lmctfy']['install_dir']}/bin/lmctfy" do
  to "#{Chef::Config[:file_cache_path]}/lmctfy/bin/lmctfy/cli/lmctfy"
end
