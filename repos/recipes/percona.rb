#
# Cookbook Name:: repos
# Recipe:: percona
#

# If we run on unsupported distro try the latest supported
if ["lenny","squeeze","hardy","lucid","maverick","natty","oneric","precise"].include?( node['lsb']['codename'] )
  codename = node["lsb"]["codename"]
elsif node['platform'] == "debian"
  codename = "squeeze"
elsif node['platform'] == "ubuntu"
  codename = "precise"
end

case node['platform']
when "debian","ubuntu"
  apt_repository "percona-apt" do
    uri "http://repo.percona.com/apt/"
    distribution "#{codename}"
    components ["main"]
    keyserver "keys.gnupg.net"
    key "1C4CBDCDCD2EFD2A"
    deb_src false
  end
end
