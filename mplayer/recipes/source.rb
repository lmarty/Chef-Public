#
# Cookbook Name:: mplayer
# Recipe:: source
#
# Copyright 2012-2013, Escape Studios
#

include_recipe "build-essential"
include_recipe "subversion" #mplayer checkout
include_recipe "git" #ffmpeg checkout
include_recipe "yasm"

creates_mplayer = "#{node[:mplayer][:prefix]}/bin/mplayer"
creates_midentify = "#{node[:mplayer][:prefix]}/bin/midentify.sh"

file "#{creates_mplayer}" do
	action :nothing
end

file "#{creates_midentify}" do
	action :nothing
end

subversion "mplayer" do
	repository node[:mplayer][:svn_repository]
	revision node[:mplayer][:svn_revision]
	destination "#{Chef::Config[:file_cache_path]}/mplayer"
	action :sync
	notifies :delete, "file[#{creates_mplayer}]", :immediately
end

#write the flags used to compile to disk
template "#{Chef::Config[:file_cache_path]}/mplayer-compiled_with_flags" do
	source "compiled_with_flags.erb"
	owner "root"
	group "root"
	mode 0600
	variables(
		:compile_flags => node[:mplayer][:compile_flags]
	)
	notifies :delete, "file[#{creates_mplayer}]", :immediately
end

bash "compile_mplayer" do
	cwd "#{Chef::Config[:file_cache_path]}/mplayer"
	code <<-EOH
		./configure --prefix=#{node[:mplayer][:prefix]} #{node[:mplayer][:compile_flags].join(' ')}
		make clean && make && make install
	EOH
	creates "#{creates_mplayer}"
	notifies :delete, "file[#{creates_midentify}]", :immediately
end

bash "copy_midentify" do
	cwd "#{Chef::Config[:file_cache_path]}/mplayer/TOOLS"
	code <<-EOH
		cp midentify.sh #{node[:mplayer][:prefix]}/bin
	EOH
	creates "#{creates_midentify}"
end