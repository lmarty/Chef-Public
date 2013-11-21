#
# Cookbook Name:: phpcb
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

#PHP Quality Assurance Toolchain PEAR channel
pearhub_chan = php_pear_channel "pear.phpqatools.org" do
	action :discover
end

#upgrade PHP_CodeBrowser
php_pear "PHP_CodeBrowser" do
	channel pearhub_chan.channel_name
	if node[:phpcb][:version] != "latest"
		version "#{node[:phpcb][:version]}"
	end
	action :upgrade if node[:phpcb][:version] == "latest"
end