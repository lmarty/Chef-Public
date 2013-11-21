#
# Cookbook Name:: pypi-mirror
# Attributes:: default
#
# Author:: Kel Phillipson (kel@kelfish.com)
#
maintainer       "Kel Phillipson"
maintainer_email "kel@kelfish.com"
license          "Apache 2.0"
description      "Installs/configures PyPi mirror using PEP381client"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.5"
recipe           "pypi-mirror", "Installs and configures PEP381client"

%w{ python apache2 }.each do |cb|
  depends cb
end

%w{ debian ubuntu }.each do |os|
  supports os
end

attribute "pypi-mirror",
  :display_name => "PyPi Mirror Hash",
  :description => "Hash of PyPi Mirror attributes",
  :type => "hash"

attribute "pypi-mirror/version",
  :display_name => "pep381client Version",
  :description => "Version number of the pep381client to install from PyPi",
  :default => "1.5"

attribute "pypi-mirror/dir",
  :display_name => "PyPi Mirror Directory",
  :description => "The directory to store the mirror PyPi",
  :default => "/var/pypi"

attribute "pypi-mirror/cgi-dir",
  :display_name => "PyPi CGI Script Directory",
  :description => "The directory to store the cgi script used for pep381client sync",
  :default => "/var/www/pypi"

attribute "pypi-mirror/server_name",
  :display_name => "FQDN of the server",
  :description => "FQDN to be used for this server",
  :default => "pypi.example.com"

attribute "pypi-mirror/cron",
  :display_name => "PyPi Mirror Cron Hash",
  :description => "Hash of PyPi Mirror Cron attributes",
  :type => "hash"

attribute "pypi-mirror/cron/minute",
  :display_name => "Sync Cron Minute",
  :description => "Minute setting for the sync cron job",
  :default => "*/15"

attribute "pypi-mirror/cron/hour",
  :display_name => "Sync Cron Hour",
  :description => "Hour setting for the sync cron job",
  :default => "*"

attribute "pypi-mirror/cron/day",
  :display_name => "Sync Cron Day",
  :description => "Day setting for the sync cron job",
  :default => "*"

attribute "pypi-mirror/cron/month",
  :display_name => "Sync Cron Month",
  :description => "Month setting for the sync cron job",
  :default => "*"

attribute "pypi-mirror/cron/weekday",
  :display_name => "Sync Cron Weekday",
  :description => "Weekday setting for the sync cron job",
  :default => "*"

attribute "pypi-mirror/logs",
  :display_name => "PyPi Mirror Logs Hash",
  :description => "Hash of PyPi Mirror Logs attributes",
  :type => "hash"

attribute "pypi-mirror/logs/minute",
  :display_name => "Logs Cron Minute",
  :description => "Minute setting for the logs cron job",
  :default => "10"

attribute "pypi-mirror/logs/hour",
  :display_name => "Logs Cron Hour",
  :description => "Hour setting for the logs cron job",
  :default => "7"

attribute "pypi-mirror/logs/day",
  :display_name => "Logs Cron Day",
  :description => "Day setting for the logs cron job",
  :default => "*"

attribute "pypi-mirror/logs/month",
  :display_name => "Logs Cron Month",
  :description => "Month setting for the logs cron job",
  :default => "*"

attribute "pypi-mirror/logs/weekday",
  :display_name => "Logs Cron Weekday",
  :description => "Weekday setting for the logs cron job",
  :default => "*"

