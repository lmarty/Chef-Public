#
# Cookbook Name:: repos
# Recipe:: virtualbox
#

case node['platform_family']
when "debian"
  apt_repository "virtualbox" do
    uri "http://download.virtualbox.org/virtualbox/debian"
    distribution node['lsb']['codename']
    components ["contrib", "non-free"]
    key "http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc"
    deb_src false
  end
end
