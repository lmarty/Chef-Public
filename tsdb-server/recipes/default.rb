# https://github.com/masiulaniec/opentsdb-rhel/raw/master/RPMS/noarch/tsdb-server-1.0-1.noarch.rpm
package "tsdb-server" do
  action :upgrade
end

template "/etc/sysconfig/tsdb-server" do
  source "server/sysconfig"
  owner "root"
  group "root"
  mode "0644"
end

template "/var/app/tsdb/share/opentsdb/logback.xml" do
  source "server/logback.xml"
  owner "root"
  group "root"
  mode "0644"
end

service "tsdb-server" do
  subscribes :restart, resources(
    :template => [
        "/etc/sysconfig/tsdb-server",
        "/var/app/tsdb/share/opentsdb/logback.xml",
    ],
    :package => ["tsdb-server"]
  ), :delayed
  supports :status => true, :restart => true
  action [ :disable, :start ]
end
