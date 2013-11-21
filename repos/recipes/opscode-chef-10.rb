#
# Cookbook Name:: repos
# Recipe:: opscode-chef-10
#

case node['platform']
when "debian","ubuntu"
  apt_repository "opscode-chef" do
    uri "http://apt.opscode.com/"
    distribution "#{node['lsb']['codename']}-0.10"
    components ["main"]
    keyserver "keys.gnupg.net"
    key "83EF826A"
    deb_src false
  end
end
