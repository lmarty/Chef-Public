#
# Cookbook Name:: phpcs
# Recipe:: pear
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

#PHPUnit PEAR channel
php_pear_channel "pear.phpunit.de" do
	action :discover
end

#upgrade phpcs
php_pear "PHP_CodeSniffer" do
	channel pearhub_chan.channel_name
	if node[:phpcs][:version] != "latest"
		version "#{node[:phpcs][:version]}"
	end
	action :upgrade if node[:phpcs][:version] == "latest"
end