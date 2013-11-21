#
# Cookbook Name:: httplivestreamsegmenter
# Recipe:: default
#
# Copyright 2012-2013, Escape Studios
#

include_recipe "build-essential"
include_recipe "git"

#libssl-dev (libcrypto)
package "libssl-dev" do
  action :upgrade
end

creates = "#{node[:httplivestreamsegmenter][:prefix]}/bin/MpegtsH264"

file "#{creates}" do
	action :nothing
end

git "#{Chef::Config[:file_cache_path]}/http-live-stream-segmenter" do
	repository node[:httplivestreamsegmenter][:git_repository]
	reference node[:httplivestreamsegmenter][:git_revision]
	action :sync
	notifies :delete, "file[#{creates}]", :immediately
end

#write the flags used to compile to disk
template "#{Chef::Config[:file_cache_path]}/httplivestreamsegmenter-compiled_with_flags" do
	source "compiled_with_flags.erb"
	owner "root"
	group "root"
	mode 0600
	variables(
		:compile_flags => node[:httplivestreamsegmenter][:compile_flags]
	)
	notifies :delete, "file[#{creates}]", :immediately
end

bash "compile_httplivestreamsegmenter" do
	cwd "#{Chef::Config[:file_cache_path]}/http-live-stream-segmenter"
	code <<-EOH
		touch README
		autoreconf
		automake --add-missing
		./configure --prefix=#{node[:httplivestreamsegmenter][:prefix]} #{node[:httplivestreamsegmenter][:compile_flags].join(' ')}
		make clean && make && make install
	EOH
	creates "#{creates}"
end