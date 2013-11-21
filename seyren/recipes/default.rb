# Cookbook Name:: seyren
# Recipe:: default

include_recipe "maven"
include_recipe "mongodb::10gen_repo"
include_recipe "tomcat"

seyrencheckoutdir = "/tmp/seyren"

application "seyren" do
  path "#{seyrencheckoutdir}"
  owner "www-data"
  group "www-data"

  shallow_clone false
  repository "https://github.com/scobal/seyren.git"
  revision "23983ce38e98ba3cb89c1dcacc3f2bd42db553db"
end

# note: setenv.sh is called by .../tomcat6/bin/catalina.sh
# and is useful to setup environment variables for tomcat
template "#{node[:tomcat][:home]}/bin/setenv.sh" do
  path "#{node[:tomcat][:home]}/bin/setenv.sh"
  source "setenv.sh.erb"
  owner "root"
  group "root"
  mode "0755"
  notifies :restart, resources(:service => "tomcat")
end

link "/usr/lib/jvm/default-java" do
  to "/usr/lib/jvm/java-6-openjdk-amd64"
end

# modify seyren.log location specified to logback
# as a "/var/log/<tomcatFolder>" based one
template "#{seyrencheckoutdir}/current/seyren-web/src/main/resources/logback.xml" do
  path "#{seyrencheckoutdir}/current/seyren-web/src/main/resources/logback.xml"
  source "logback.xml.erb"
  owner "www-data"
  group "www-data"
  mode "0755"
  notifies :run, "execute[create seyren war]", :immediately
end

execute "create seyren war" do
  command "/usr/local/maven/bin/mvn clean package -DskipTests"
  cwd "#{seyrencheckoutdir}/current/"
  creates "#{seyrencheckoutdir}/current/seyren-web/target/seyren-web-0.1-SNAPSHOT.war"
  action :run
end

execute "copy seyren war to tomcat webapps" do
  command "cp seyren-web-0.1-SNAPSHOT.war #{node[:tomcat][:webapp_dir]}/seyren.war"
  cwd "#{seyrencheckoutdir}/current/seyren-web/target"
  creates "#{node[:tomcat][:webapp_dir]}/seyren.war"
  action :run
  notifies :restart, "service[tomcat]", :immediately
end

if node['seyren']['apache_auth']['realm'] != nil && node['seyren']['apache_auth']['vhost_servername'] != nil && node['apache_auth_group'] != nil

  include_recipe "apache2::mod_auth_digest"
  include_recipe "apache2::mod_rewrite"
  include_recipe "apache2::mod_proxy"
  include_recipe "apache2::mod_proxy_http"

  template "#{node['apache']['dir']}/sites-available/seyren" do
    source "seyren-vhost.conf.erb"
    notifies :restart, resources(:service => "apache2")
  end

  auth_users = search(:users, "groups:#{node['apache_auth_group']} AND pwdigest:*")
  
  template "#{node['apache']['dir']}/users.digest" do
    source "users.digest.erb"
    mode 0644
    owner "root"
    group "root"
    backup false
    variables(
      :users => auth_users
    )
  end

  apache_site "seyren"

end
