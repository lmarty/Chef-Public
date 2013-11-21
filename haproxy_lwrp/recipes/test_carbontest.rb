# install haproxy
haproxy_source_file = "haproxy_1.5-dev17-1ubuntu1_#{node['kernel']['machine'] =~ /x86_64/ ? "amd64" : "i386"}.deb"

remote_file Chef::Config[:file_cache_path] + "/" + haproxy_source_file do
  source "https://mopub-debs.s3.amazonaws.com/haproxy/#{node['platform_version']}/#{node['kernel']['machine'] =~ /x86_64/ ? "amd64" : "i386"}/#{haproxy_source_file}"
  not_if { ::File.exists?(Chef::Config[:file_cache_path] + haproxy_source_file) }
end

package "haproxy" do
  source Chef::Config[:file_cache_path] + "/" + haproxy_source_file
  provider Chef::Provider::Package::Dpkg
  action :install
  not_if { File.exists?("/usr/sbin/haproxy") }
end
listen_temp=Array.new

listen_temp << { "name" => "carbon-relay-plain 0.0.0.0:2003", "mode" => "tcp", "server" => ["127.0.0.1"], "start_port" => 2031, "instance_count" => 3}
listen_temp << { "name" => "carbon-relay-pickle 0.0.0.0:2004", "mode" => "tcp", "server" => ["127.0.0.1"], "start_port" => 2041, "instance_count" => 3}

include_recipe "runit"
haproxy_lwrp_lb "carbon" do
  global({"maxconn" => 65535, "ulimit-n" => 160000, "user" => "haproxy", "group" => "haproxy", "stats" => "socket /var/run/haproxy.sock mode 0600 level admin user root" })
  defaults({ "log" => "global", "mode" => "http", "option" => "dontlognull", "balance" => "leastconn", "srvtimeout" => 60000, "contimeout" => 5000, "retries" => 3,"option" => "redispatch\noption contstats"})
  listen(listen_temp)
  action :create
end
