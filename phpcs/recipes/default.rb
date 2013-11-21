#
# Cookbook Name:: phpcs
# Recipe:: default
#
# Copyright 2013, Escape Studios
#

case node[:phpcs][:install_method]
	when "pear"
		include_recipe "phpcs::pear"
	when "composer"
		include_recipe "phpcs::composer"
end