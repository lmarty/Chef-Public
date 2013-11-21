#
# Cookbook Name:: jboss-atg
# Recipe:: default
# Originally written by Bryan W. Berry

# Modifications 2012, by John Larsen - Addolux LLC
# to accommodate the ATG Cookbook.
#
#

## Declarations to simplify this recipe.
jboss_root = node['jboss']['jboss_root']
jboss_user = node['jboss']['jboss_user']
jboss_install = node['jboss']['dl_url'] + "/" + node['jboss']['binary_file']

directory jboss_root do
  mode "0755"
end

## This downloads the jboss tar file.
  remote_file File.join( jboss_root, "#{node.jboss.binary_file}" ) do
    source jboss_install
    not_if { File.exist?("#{jboss_root}/#{node.jboss.binary_file}") }
  end


## Untar jboss tar
bash "untar_jboss" do
  user "root"
  cwd jboss_root
  code <<-EOH
  tar -xvzf #{node.jboss.binary_file}
  EOH
  notifies :run, "execute[fix_jboss_perms]"
  not_if { File.exist?("#{jboss_root}/#{node.jboss.version}") }
end

## Swap out cglib.jar
file "#{jboss_root}/#{node.jboss.version}/jboss-as/common/lib/cglib.jar" do
  action :delete
end

remote_file "#{jboss_root}/#{node.jboss.version}/jboss-as/common/lib/cglib.jar" do
  source "#{jboss.dl_url}/#{jboss.cglib_jar}"
  owner "jboss"
  group "jboss"
  mode "0755"
end

# ln -s jboss-as jboss-eap-5.1/jboss-as
link "#{node.jboss.jboss_root}/jboss-as" do
  to "#{node.jboss.jboss_root}/#{node.jboss.version}/jboss-as"
end

## Provides chown function when needed.
execute "fix_jboss_perms" do
  command "chown -R #{jboss_user}:#{jboss_user} #{jboss_root}"
  returns [0,2]
  action :nothing
end

## template init file
template "/etc/init.d/jboss" do
  source "init_rhel.erb"
  mode "0755"
  owner "root"
  group "root"
end

## For upgrade or version change clean up
if node[:jboss][:cleanup] = "yes"
  directory "#{node.jboss.jboss_root}/#{node.jboss.old_version}" do
    recursive true
    action :delete
  end
  
  directory "#{node.jboss.jboss_root}/#{node.jboss.old_binary}" do
    recursive true
    action :delete
  end
end


