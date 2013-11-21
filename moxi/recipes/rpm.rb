remote_file "#{Chef::Config[:file_cache_path]}/moxi-server.rpm" do
  source "http://packages.couchbase.com/releases/1.8.1/moxi-server_x86_64_1.8.1.rpm"
end

yum_package "moxi-server" do
  source "#{Chef::Config[:file_cache_path]}/moxi-server.rpm"
end
