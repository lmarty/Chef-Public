# create working directory
directory node['redis']['work_dir'] do
  action :create
  not_if "ls -d #{node['redis']['work_dir']}"
end

# get newer source code
remote_file node['redis']['work_dir'] + node['redis']['source_file_name'] do
  source node['redis']['source_url_path'] + node['redis']['source_file_name']
  not_if "ls #{node['redis']['server_install_path']}"
end

# make && make test && make install
bash "install_redis_program" do
  user "root"
  cwd node['redis']['work_dir']
  code <<-EOH
    tar -zxf #{node['redis']['source_file_name']}
    cd #{::File.basename(node['redis']['source_file_name'], '.tar.gz')}
    make
    make install
  EOH
  not_if {File.exists? "#{node['redis']['server_install_path']}"}
end

# create user 'redis'
user node['redis']['user'] do
  comment "redis system"
  system true
  shell "/bin/false"
  not_if "id #{node['redis']['user']}"
end

# execute update-rc.d 
execute "update_rc_d" do
  command "update-rc.d redis-server defaults"
  action :nothing
end

# create startup script
template "/etc/init.d/redis-server" do
  source "redis-server.erb"
  owner "root"
  group "root"
  mode 00755
  variables(
    :redis_server_path => node['redis']['server_install_path'],
    :redis_conf_path => node['redis']['server_conf_path'],
    :redis_user => node['redis']['user']  
  )
  notifies :run, 'execute[update_rc_d]', :immediately
  not_if {File.exists?("/etc/init.d/redis-server")}
end

# create redis.conf 
template node['redis']['server_conf_path'] do
  source "redis.conf.erb"
  owner node['redis']['user']
  group node['redis']['user']
  mode 00644
  variables(
    :redis_server_daemonize => node['redis']['server_daemonize'],
    :redis_server_data_path => node['redis']['server_data_path'],
  )
  notifies :restart, "service[redis-server]" 
end

# create redis data directory
directory node['redis']['server_data_path'] do
  owner node['redis']['user']
  group node['redis']['user']
  mode 0775
  action :create
  not_if {File.exists? "#{node['redis']['server_data_path']}"}
end

# start redis-server 
service "redis-server" do
  supports :start => true, :restart => true, :stop => true
  action [:enable, :start]
  only_if "id #{node['redis']['user']}"
end
