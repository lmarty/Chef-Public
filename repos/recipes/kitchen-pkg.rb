#
# Cookbook Name:: repos
# Recipe:: kitchen-pkg
#

case node['platform']
when "debian"
  apt_repository "kitchen-pkg" do
    uri "http://192.168.33.1/chef/repos/debian"
    distribution "/"
    deb_src false
  end
end

apt_preference "kitchen-pkg" do
  glob "*"
  pin "origin 192.168.33.1"
  pin_priority "1001"
end


