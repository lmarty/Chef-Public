case node['platform_family']
when "debian"

  apt_repository "zotonic" do
    uri "http://ppa.launchpad.net/arjan-scherpenisse/zotonic/ubuntu"
    distribution node['lsb']['codename']
    components ["main"]
    keyserver "keyserver.ubuntu.com"
    key "150D3DC1"
  end

  package "zotonic"
end
