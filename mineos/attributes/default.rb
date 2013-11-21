#
# Cookbook Name:: mineos
#
# Copyright 2013, ka’imi
#

default['mineos']['group'] = "mineos"
default['mineos']['basedir'] = "/srv/mineos"
default['mineos']['repository'] = "https://github.com/hexparrot/mineos.git"
default['mineos']['version'] = "master"

default['mineos']['profile_fix']['enable'] = false
default['mineos']['profile_fix']['versions'] = []

default['mineos']['service']['enable'] = true

default['mineos']['config']['basedir'] = "/var/games/minecraft"
default['mineos']['config']['locale'] = "en"
default['mineos']['config']['logfile'] = "/var/log/mineos.log"
default['mineos']['config']['host']['address'] = "0.0.0.0"
default['mineos']['config']['host']['port'] = 8080
default['mineos']['config']['ssl']['enable'] = true
default['mineos']['config']['ssl']['generate'] = true
default['mineos']['config']['ssl']['cert'] = "/etc/ssl/certs/mineos.crt"
default['mineos']['config']['ssl']['key'] = "/etc/ssl/certs/mineos.key"
default['mineos']['config']['ssl']['ca'] = ""
default['mineos']['config']['ssl']['chain'] = ""
