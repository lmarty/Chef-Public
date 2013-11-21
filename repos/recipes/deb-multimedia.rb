#
# Cookbook Name:: repos
# Recipe:: deb-multimedia
#

repo_uri='http://www.deb-multimedia.org'

mirrors = {
  "nsu" => "http://debian.nsu.ru/debian-marillat/",
  "yandex" => "http://mirror.yandex.ru/debian-multimedia/",
  "mephi" => "http://mirror.mephi.ru/debian-multimedia/",
  "mephi-ftp" => "ftp://mirror.mephi.ru/debian-multimedia/"
}

if node['repos_mirrors'] and
    node['repos_mirrors']['deb-multimedia'] and
    mirrors[ node['repos_mirrors']['deb-multimedia'] ]
  repo_uri = mirrors[ node['repos_mirrors']['deb-multimedia']]
end

case node['platform']
when "debian"
  apt_repository "deb-multimedia" do
    uri repo_uri
    distribution "#{node['lsb']['codename']}"
    components ["main", "non-free"]
    deb_src false
  end

  package "deb-multimedia-keyring" do
    options "--allow-unauthenticated"
  end
end
