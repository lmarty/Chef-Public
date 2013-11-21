#
# Cookbook Name:: phpcs
# Attributes:: default
#
# Copyright 2013, Escape Studios
#

default[:phpcs][:install_method] = "pear"
default[:phpcs][:version] = "latest"

#composer install only
default[:phpcs][:prefix] = "/usr/bin"