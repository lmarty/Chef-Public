#
# Cookbook Name:: phpcpd
# Recipe:: default
#
# Copyright 2013, Escape Studios
#

include_recipe "php"

#PHP Extension and Application Repository PEAR channel
pearhub_chan = php_pear_channel "pear.php.net" do
  action :update
end

#upgrade PEAR
php_pear "PEAR" do
	channel pearhub_chan.channel_name
	action :upgrade
end

#eZ Enterprise components PEAR channel
php_pear_channel "components.ez.no" do
	action :discover
end

#Netpirates PEAR channel
php_pear_channel "pear.netpirates.net" do
	action :discover
end

#Symfony2 PEAR channel
php_pear_channel "pear.symfony.com" do
	action :discover
end

#PHPUnit PEAR channel
pearhub_chan = php_pear_channel "pear.phpunit.de" do
	action :discover
end

#upgrade phpcpd
php_pear "phpcpd" do
	channel pearhub_chan.channel_name
	if node[:phpcpd][:version] != "latest"
		version "#{node[:phpcpd][:version]}"
	end
	action :upgrade if node[:phpcpd][:version] == "latest"
end