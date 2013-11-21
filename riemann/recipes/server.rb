#
# Cookbook Name:: riemann
# Recipe:: server
#
#

execute "apt-get update"

%w{build-essential wget libyaml-dev zlib1g-dev libreadline-dev libssl-dev tk-dev libgdbm-dev openjdk-6-jdk gem}.each do |pkg|
  package pkg do
    action [:install]
  end
end

script "install_riemann" do
  interpreter "bash"
  user "root"
  cwd "/opt/"
  creates "/opt/riemann"
  code <<-EOH
  STATUS=0
  wget #{node[:riemann][:riemann_tarball_location]} || STATUS=1
  mkdir #{node[:riemann][:riemann_install_location]} || STATUS=1
  tar xvfj /opt/#{node[:riemann][:riemann_tarball]} || STATUS=1
  cp /opt/#{node[:riemann][:riemann_version]}/* /opt/riemann/
  rm -rf /opt/#{node[:riemann][:riemann_version]}
  exit $STATUS
  EOH
end

include_recipe "riemann::client"

