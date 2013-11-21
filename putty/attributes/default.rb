default['putty']['version']      = "0.62"
default['putty']['url']          = "http://the.earth.li/~sgtatham/putty/#{default['putty']['version']}/x86/putty-#{default['putty']['version']}-installer.exe"
default['putty']['package_name'] = "PuTTY version #{default['putty']['version']}"

default['putty']['home']    = "#{ENV['SYSTEMDRIVE']}\\putty"
