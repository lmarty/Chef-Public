#
# Cookbook Name:: sox_mp3
# Recipe:: install_unbuntu
#
# Author:: Gabriel Cebrian (<gabceb@gmail.com>)
#
# Copyright 2013, Gabriel Cebrian.
#
# Licensed under the MIT License
#

full_path = "#{node['sox_mp3']['source_folder']}/sox-#{node['sox_mp3']['version']}"
installed = "#{full_path}/.installed"
version = node['sox_mp3']['version']

%w{fakeroot dpkg-dev devscripts}.each do |pkg|
	apt_package pkg do
  		action :install
	end
end

execute "install_sox_dep" do
  cwd "/tmp"
  command "apt-get build-dep sox -y"
  action :run
end

apt_package "libmp3lame-dev" do
	action :install
end

bash "enable_sox_mp3" do
	cwd "/tmp"

	code <<-EOH
		mkdir #{node['sox_mp3']['source_folder']} && cd #{node['sox_mp3']['source_folder']}
		apt-get source sox=#{version} -y
		cd sox-#{version}
	EOH

	not_if { ::File.exists?(full_path) }
end

bash "change_compile_sox" do
	cwd full_path

	code <<-EOH
		sed -i 's/--without-lame //' debian/rules
		sed -i 's/libmagic-dev, /libmagic-dev, libmp3lame-dev, /' debian/control
		sed -i 's/Write support not available yet.//' debian/control
		fakeroot debian/rules binary
		sudo dpkg -i ../*.deb
		fakeroot debian/rules clean
		touch #{installed}
	EOH

	not_if { ::File.exists?(installed) }
end