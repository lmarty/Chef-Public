#
# Cookbook Name:: bonita
# Recipe:: default
#
# Copyright 2011, Peter Donald
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

node.override['tomcat']['common_loader_additions'] =["#{node['bonita']['home_dir']}/lib/bonita/*.jar"]

java_options = ""
java_options += " -DBONITA_HOME=#{node['bonita']['home_dir']}/bonita"
java_options += " -Djava.security.auth.login.config=#{node['bonita']['home_dir']}/external/security/jaas-tomcat.cfg"
java_options += " -Djava.util.logging.config.file=#{node['bonita']['home_dir']}/external/logging/logging.properties"
java_options += " -Dexo.data.dir=#{node['bonita']['home_dir']}/external/xcmis/ext-exo-data"
java_options += " -Dfile.encoding=UTF-8 -Xshare:auto -Xms512m -Xmx2048m -XX:MaxPermSize=256m -XX:+HeapDumpOnOutOfMemoryError"
java_options += " -Dorg.exoplatform.container.standalone.config=#{node['bonita']['home_dir']}/external/xcmis/ext-exo-conf/exo-configuration.xml"
java_options += " -Djava.awt.headless=true"
node.override['tomcat']['java_options'] = java_options

include_recipe "tomcat::default"

raise "node['bonita']['packages']['bonita'] not set" unless node['bonita']['packages']['bonita']
raise "node['bonita']['packages']['client'] not set" unless node['bonita']['packages']['client']
raise "node['bonita']['packages']['keygen'] not set" unless node['bonita']['packages']['keygen']
raise "node['bonita']['packages']['xcmis'] not set" unless node['bonita']['packages']['xcmis']
raise "node['bonita']['database']['jdbc']['username'] not set" unless node['bonita']['database']['jdbc']['username']
raise "node['bonita']['database']['jdbc']['password'] not set" unless node['bonita']['database']['jdbc']['password']
raise "node['bonita']['xcmis']['username'] not set" unless node['bonita']['xcmis']['username']
raise "node['bonita']['xcmis']['password'] not set" unless node['bonita']['xcmis']['password']

["",
 "/bonita",
 "/bonita/client",
 "/bonita/server",
 "/bonita/server/licenses",
 "/bonita/server/default",
 "/bonita/server/default/conf",
 "/external",
 "/external/logging",
 "/external/security",
 "/external/xcmis",
 "/external/xcmis/ext-exo-conf",
 "/lib",
 "/lib/bonita",
].each do |directory|
  directory "#{node['bonita']['home_dir']}#{directory}" do
    owner node['tomcat']['user']
    group node['tomcat']['group']
    mode '0700'
    recursive true
  end
end

bonita_filename = "#{node['bonita']['home_dir']}/bpm-bonita-#{node['bonita']['version']}.war"
remote_file bonita_filename do
  source node['bonita']['packages']['bonita']
  mode '0600'
  owner node['tomcat']['user']
  group node['tomcat']['group']
  action :create_if_missing
end

client_filename = "#{node['bonita']['home_dir']}/bpm-client-#{node['bonita']['version']}.zip"
remote_file client_filename do
  source node['bonita']['packages']['client']
  mode '0600'
  owner node['tomcat']['user']
  group node['tomcat']['group']
  action :create_if_missing
end

keygen_filename = "#{node['bonita']['home_dir']}/bpm-keygen-#{node['bonita']['version']}.jar"
remote_file keygen_filename do
  source node['bonita']['packages']['keygen']
  mode '0600'
  owner node['tomcat']['user']
  group node['tomcat']['group']
  action :create_if_missing
end

xcmis_filename = "#{node['bonita']['home_dir']}/bpm-xcmis-#{node['bonita']['version']}.war"
remote_file xcmis_filename do
  source node['bonita']['packages']['xcmis']
  mode '0600'
  owner node['tomcat']['user']
  group node['tomcat']['group']
  action :create_if_missing
end

package 'zip'

execute "unzip client libs" do
  command <<CMD
umask 0600
unzip -u -o "#{node['bonita']['home_dir']}/#{File.basename(node['bonita']['packages']['client'])}"
CMD
  user node['tomcat']['user']
  group node['tomcat']['group']
  cwd "#{node['bonita']['home_dir']}/bonita/client"
  action :run
  not_if { ::File.exist?("#{node['bonita']['home_dir']}/bonita/client/tenants/default/web/XP/looknfeel/default/BonitaConsole.html") }
end

ruby_block "generate_license_request" do
  block do
    dev_mode = node['bonita']['license']['type'] != 'production'
    node.override['bonita']['license']['request'] =
      `echo #{node['cpu']['total']} | java -cp #{keygen_filename} org.bonitasoft.security.generateKey.GenerateKey#{dev_mode ? 'Dev' : ''} | tail -n 1`
  end
end

node['bonita']['extra_libraries'].each do |library|
  filename = "#{node['bonita']['home_dir']}/lib/bonita/#{File.basename(library)}"
  remote_file filename do
    source library
    owner node['tomcat']['user']
    group node['tomcat']['group']
    mode '0600'
    action :create_if_missing
    notifies :restart, 'service[tomcat]', :delayed
  end
end

if node['bonita']['license']['url']
  remote_file "#{node['bonita']['home_dir']}/bonita/server/licenses/license.lic" do
    source node['bonita']['license']['url']
    owner node['tomcat']['user']
    group node['tomcat']['group']
    mode '0600'
  end
end

template "#{node['bonita']['home_dir']}/bonita/server/default/conf/bonita-history.properties" do
  source 'bonita-history.properties.erb'
  owner node['tomcat']['user']
  group node['tomcat']['group']
  mode '0600'
  notifies :restart, 'service[tomcat]', :delayed
end

logging_properties = {
  "handlers" => "java.util.logging.FileHandler",
  ".level" => "INFO",
  "java.util.logging.FileHandler.pattern" => "#{node['tomcat']['log_dir']}/bonita%u.log",
  "java.util.logging.FileHandler.limit" => "50000",
  "java.util.logging.FileHandler.count" => "1",
  "java.util.logging.FileHandler.formatter" => "java.util.logging.SimpleFormatter",
  "org.ow2.bonita.level" => "INFO",
  "org.ow2.bonita.example.level" => "FINE",
  "org.ow2.bonita.runtime.event.EventDispatcherThread.level" => "WARNING",
  "org.bonitasoft.level" => "INFO",
  "org.hibernate.level" => "WARNING",
  "net.sf.ehcache.level" => "SEVERE",
  "org.apache.catalina.session.PersistentManagerBase.level" => "OFF"
}

logging_properties.merge!(node['bonita']['logging_properties'].to_hash)

template "#{node['bonita']['home_dir']}/external/logging/logging.properties" do
  source 'logging.properties.erb'
  cookbook 'bonita'
  owner node['tomcat']['user']
  group node['tomcat']['group']
  mode '0600'
  variables(:logging_properties => logging_properties)
  notifies :restart, 'service[tomcat]', :delayed
end

template "#{node['bonita']['home_dir']}/bonita/server/default/conf/bonita-journal.properties" do
  source 'bonita-journal.properties.erb'
  owner node['tomcat']['user']
  group node['tomcat']['group']
  mode '0600'
  notifies :restart, 'service[tomcat]', :delayed
end

template "#{node['bonita']['home_dir']}/external/xcmis/ext-exo-conf/exo-configuration.xml" do
  source 'exo-configuration.xml.erb'
  owner node['tomcat']['user']
  group node['tomcat']['group']
  mode '0600'
  notifies :restart, 'service[tomcat]', :delayed
end

template "#{node['bonita']['home_dir']}/external/xcmis/ext-exo-conf/cmis-jcr-configuration.xml" do
  source 'cmis-jcr-configuration.xml.erb'
  owner node['tomcat']['user']
  group node['tomcat']['group']
  mode '0600'
  notifies :restart, 'service[tomcat]', :delayed
end

["cmis-nodetypes-config.xml", "nodetypes-config-extended.xml", "nodetypes-config.xml", "organization-nodetypes.xml"].
  each do |config_filename|
  cookbook_file "#{node['bonita']['home_dir']}/external/xcmis/ext-exo-conf/#{config_filename}" do
    source "xcmis/#{config_filename}"
    owner node['tomcat']['user']
    group node['tomcat']['group']
    mode '0600'
    notifies :restart, 'service[tomcat]', :delayed
  end
end

cookbook_file "#{node['bonita']['home_dir']}/external/security/jaas-tomcat.cfg" do
  source "jaas-tomcat.cfg"
  owner node['tomcat']['user']
  group node['tomcat']['group']
  mode '0600'
  notifies :restart, 'service[tomcat]', :delayed
end

template "#{node['bonita']['home_dir']}/bonita/server/default/conf/bonita-server.xml" do
  source 'bonita-server.xml.erb'
  owner node['tomcat']['user']
  group node['tomcat']['group']
  mode '0600'
  notifies :restart, 'service[tomcat]', :delayed
end

directory "#{node["tomcat"]["webapp_dir"]}/bonita" do
  recursive true
  action :nothing
end

template "#{node['tomcat']['context_dir']}/bonita.xml" do
  source 'bonita-context.xml.erb'
  owner node['tomcat']['user']
  group node['tomcat']['group']
  mode '0600'
  variables(:war => bonita_filename)
  notifies :restart, 'service[tomcat]', :delayed
  notifies :delete, "directory[#{node['tomcat']['webapp_dir']}/bonita]", :immediate
end

directory "#{node["tomcat"]["webapp_dir"]}/xcmis" do
  recursive true
  action :nothing
end

template "#{node['tomcat']['context_dir']}/xcmis.xml" do
  source 'xcmis-context.xml.erb'
  owner node['tomcat']['user']
  group node['tomcat']['group']
  mode '0600'
  variables(:war => xcmis_filename)
  notifies :restart, 'service[tomcat]', :delayed
  notifies :delete, "directory[#{node['tomcat']['webapp_dir']}/xcmis]", :immediate
end

file "#{node['tomcat']['context_dir']}/manager.xml" do
  action :delete
  notifies :restart, 'service[tomcat]', :delayed
end

file "#{node['tomcat']['context_dir']}/host-manager.xml" do
  action :delete
  notifies :restart, 'service[tomcat]', :delayed
end
