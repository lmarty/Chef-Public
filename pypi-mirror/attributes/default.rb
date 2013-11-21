#
# Cookbook Name:: pypi-mirror
# Attributes:: default
#
# Author:: Kel Phillipson (kel@kelfish.com)
#

default['pypi-mirror']['version']         = 1.5
default['pypi-mirror']['dir']             = '/var/pypi'
default['pypi-mirror']['cgi-dir']         = '/var/www/pypi'
default['pypi-mirror']['server_name']     = 'pypi.example.com'

default['pypi-mirror']['cron']['minute']  = '*/15'
default['pypi-mirror']['cron']['hour']    = '*'
default['pypi-mirror']['cron']['day']     = '*'
default['pypi-mirror']['cron']['month']   = '*'
default['pypi-mirror']['cron']['weekday'] = '*'

default['pypi-mirror']['logs']['minute']  = '10'
default['pypi-mirror']['logs']['hour']    = '7'
default['pypi-mirror']['logs']['day']     = '*'
default['pypi-mirror']['logs']['month']   = '*'
default['pypi-mirror']['logs']['weekday'] = '*'
