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
