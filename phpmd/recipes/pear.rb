#
# Cookbook Name:: phpmd
# Recipe:: pear
#
# Copyright 2013, Escape Studios
#

include_recipe "php"
include_recipe "pdepend::pear"

#PHP Extension and Application Repository PEAR channel
pearhub_chan = php_pear_channel "pear.php.net" do
  action :update
end

#upgrade PEAR
php_pear "PEAR" do
    channel pearhub_chan.channel_name
    action :upgrade
end

#phpmd PEAR channel
pearhub_chan = php_pear_channel "pear.phpmd.org" do
    action :discover
end

#upgrade phpmd
php_pear "PHP_PMD" do
    channel pearhub_chan.channel_name
    if node[:phpmd][:version] != "latest"
        version "#{node[:phpmd][:version]}"
    end
    action :upgrade if node[:phpmd][:version] == "latest"
end