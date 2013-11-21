#
# Cookbook Name:: playonlinux
# Recipe:: default
#

apt_repository "playonlinux" do
  uri "http://deb.playonlinux.com/"
#  distribution node['lsb']['codename']
# hard-coded to 'precise' because there's no 'quantal' package
  distribution 'precise'
  components ["main"]
  keyserver "keyserver.ubuntu.com"
  key "E0F72778C4676186"
end

package "p7zip-full"

package "playonlinux"
