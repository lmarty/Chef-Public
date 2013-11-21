#
# Cookbook Name:: geoip
# Recipe:: default
#
# Installs GeoIP database and lookup executables
#

package "geoip-database" do
  action :upgrade
end

package "geoip-bin" do
  action :upgrade
end

package "libgeoip-dev" do
  action :upgrade
end
