#
# Cookbook Name:: repos
# Recipe:: debian
#

repo_uri='http://cdn.debian.net/debian/'

mirrors = {
  "nsu" => "http://debian.nsu.ru/debian/",
  "yandex" => "http://mirror.yandex.ru/debian/",
  "mephi" => "http://mirror.mephi.ru/debian/"
}

if node['repos_mirrors'] and
    node['repos_mirrors']['deb-multimed'] and
    mirrors[ node['repos_mirrors']['deb-multimedia'] ]
  repo_uri = mirrors[ node['repos_mirrors']['deb-multimedia']]
end

case node['platform']
when "debian"
  apt_repository "debian" do
    uri repo_uri
    distribution "#{node['lsb']['codename']}"
    components ["main", "contrib", "non-free"]
    deb_src true
  end

  package "debian-keyring" do
    options "--allow-unauthenticated"
  end
end
