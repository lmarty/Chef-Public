directory "#{node['terracotta']['install_dir']}" do
  mode "0755"
end

cookbook_file "#{node['terracotta']['installer_archive']}" do
  mode "0644"
end

script "unpack_archive" do
  interpreter "bash"
  cwd "#{node['terracotta']['install_dir']}"
  code "umask 0022 && tar -xvzf #{node['terracotta']['installer_archive']}"
  not_if "test -d #{node['terracotta']['home']}"
end

directory "#{node.terracotta.home}/logs" do
  mode "0755"
end
directory "#{node.terracotta.home}/cluster" do
  mode "0755"
end

directory "#{node.terracotta.home}/platform" do
  mode "0755"
end
directory "#{node.terracotta.home}/platform/modules" do
  mode "0755"
end
directory "#{node.terracotta.home}/platform/modules/org" do
  mode "0755"
end
directory "#{node.terracotta.home}/platform/modules/org/modules" do
  mode "0755"
end
node["terracotta"]["tims"].each do |tim,version|
  directory "#{node.terracotta.home}/platform/modules/org/modules/tim-#{tim}" do
    mode "0755"
  end
  directory "#{node.terracotta.home}/platform/modules/org/modules/tim-#{tim}/#{version}" do
    mode "0755"
  end
  cookbook_file "#{node.terracotta.home}/platform/modules/org/modules/tim-#{tim}/#{version}/tim-#{tim}-#{version}.jar" do
    mode "0644"
  end
end
directory "#{node.terracotta.home}/platform/modules/org/toolkit" do
  mode "0755"
end
node["terracotta"]["toolkits"].each do |tk,version|
  directory "#{node.terracotta.home}/platform/modules/org/toolkit/terracotta-toolkit-#{tk}" do
    mode "0755"
  end
  directory "#{node.terracotta.home}/platform/modules/org/toolkit/terracotta-toolkit-#{tk}/#{version}" do
    mode "0755"
  end
  cookbook_file "#{node.terracotta.home}/platform/modules/org/toolkit/terracotta-toolkit-#{tk}/#{version}/terracotta-toolkit-#{tk}-#{version}.jar" do
    mode "0644"
  end
end

template "/etc/init.d/terracotta" do
  source "terracotta-init.erb"
  mode '0755'
  action :create
end

service "terracotta" do
  action [ :enable, :start ]
end

template "#{node.terracotta.home}/tc-config.xml" do
  source "tc-config.xml.erb"
  notifies :restart, resources(:service => "terracotta")
  action :create
  variables(
    # Find all other terracotta nodes in this environment
#    :servers => search(:node, 'chef_environment:#{node.chef_environment} AND recipes:terracotta')
    :servers => search(:node, 'recipes:terracotta')
  )
end

link "#{node.terracotta.home}/logs/server" do
  to "#{node.terracotta.home}/cluster/server/logs"
end

link "/var/log/terracotta" do
  to "#{node.terracotta.home}/logs"
end
