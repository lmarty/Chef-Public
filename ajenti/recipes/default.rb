#
# Cookbook Name:: cookbook-ajenti
# Recipe:: default
#
# Copyright 2013, Egor Medvedev

include_recipe value_for_platform(
	[ "debian", "ubuntu" ] => { "default" => "ajenti::debian" },
	[ "centos", "redhat", "suse", "fedora" ] => { "default" => "ajenti::centos" }
	)

service "ajenti" do
	supports :start => true, :stop => true, :restart => true
	action :nothing
end