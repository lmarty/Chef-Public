#
# Cookbook Name:: pdepend
# Recipe:: pear
#
# Copyright 2013, Escape Studios
#

include_recipe "php"

#PHP Extension and Application Repository PEAR channel
php_pear_channel "pear.php.net" do
  action :update
end

#upgrade PEAR
php_pear "PEAR" do
    action :upgrade
end

#pdepend PEAR channel
pearhub_chan = php_pear_channel "pear.pdepend.org" do
    action :discover
end

#upgrade pdepend
php_pear "PHP_Depend-beta" do
    channel pearhub_chan.channel_name
    if node[:pdepend][:version] != "latest"
        version "#{node[:pdepend][:version]}"
    end
    action :upgrade if node[:pdepend][:version] == "latest"
end