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

frontend_temp=Array.new
frontend_temp << {"name" => "http-in *:80", "acl" => "acl adserver-local-true path_beg /local/adunit_context_update\nacl adserver-local-true path_beg /local/adunit_worker\nuse_backend adserver-cpp if adserver-local-true\n", "default_backend" => "adserver-cpp" }
frontend_temp << {"name" => "https-in *:443", "default_backend" => "adserver" }
backend_temp=Array.new
backend_temp << { "name" => "adserver", "mode" => "http", "balance" => "leastconn" , "option" => "option httpclose\noption redispatch\noption httpchk GET / HTTP/1.1\\r\\nHost: wwww\noption redispatch\n", "other" => "check", "server" => ["172.29.11.3","172.29.11.4"], "start_port" => 5000, "instance_count" => 4}
backend_temp << { "name" => "adserver-cpp", "mode" => "http", "balance" => "leastconn" , "option" => "option httpclose\noption redispatch\noption httpchk GET / HTTP/1.1\\r\\nHost: wwww\noption redispatch\n", "other" => "check", "server" => ["172.29.11.4","172.29.11.8"], "maxconn" => 512, "start_port" => 5000, "instance_count" => 4}
listen_temp=Array.new
listen_temp <<   {"name" => "admin 0.0.0.0:22002", "mode" => "http", "stats" => "stats uri /"}

include_recipe "runit"
haproxy_lwrp_lb "adserver" do
  name "adserver"
  frontend(frontend_temp)
  backend(backend_temp)
  listen(listen_temp)
  action :create
end
