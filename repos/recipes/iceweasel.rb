#
# Cookbook Name:: repos
# Recipe:: mozilla-deb
#

case node['lsb']['codename']
when "wheezy"
  package "pkg-mozilla-archive-keyring" do
    options "--allow-unauthenticated"
  end

  apt_repository "mozilla-iceweasel" do
    uri "http://mozilla.debian.net/"
    distribution "experimental"
    components [ node["repo"]["iceweasel"]["version"] ]
    deb_src false
  end
end
