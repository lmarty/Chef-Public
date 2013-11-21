#
# Cookbook Name:: gpac
# Recipe:: source
#
# Copyright 2012-2013, Escape Studios
#

include_recipe "build-essential"
include_recipe "subversion"

creates = "#{node[:gpac][:prefix]}/bin/MP4Box"

file "#{creates}" do
	action :nothing
end

subversion "gpac" do
	repository node[:gpac][:svn_repository]
	revision node[:gpac][:svn_revision]
	destination "#{Chef::Config[:file_cache_path]}/gpac"
	action :sync
	notifies :delete, "file[#{creates}]", :immediately
end

#write the flags used to compile to disk
template "#{Chef::Config[:file_cache_path]}/gpac-compiled_with_flags" do
	source "compiled_with_flags.erb"
	owner "root"
	group "root"
	mode 0600
	variables(
		:compile_flags => node[:gpac][:compile_flags]
	)
	notifies :delete, "file[#{creates}]", :immediately
end

bash "compile_gpac" do
	cwd "#{Chef::Config[:file_cache_path]}/gpac"
	code <<-EOH
		./configure --prefix=#{node[:gpac][:prefix]} #{node[:gpac][:compile_flags].join(' ')}
		make clean && make && make install
	EOH
	creates "#{creates}"
end