#
# Cookbook Name:: cookbook-ajenti
# Recipe:: default
#
# Copyright 2013, Egor Medvedev

include_recipe "apt"

case case node[:platform_version]
when < "7.0"
	apt_repository "backports" do
		uri "http://mirror.yandex.ru/debian-backports"
		distribution "oldstable-backports"
		components ["main"]
		action :add
	end
end

apt_repository "ajenti" do
  uri "http://repo.ajenti.org/debian"
  distribution "main"
  components ["main"]
  key "http://repo.ajenti.org/debian/key"
  action :add
end

package "ajenti"
include_recipe "ajenti::setup"