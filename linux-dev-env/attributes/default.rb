#
# Cookbook Name:: linux-dev-env
# Recipe:: default
#
# Copyright 2012, Gerald L. Hevener Jr., M.S.
#

# Set Android SDK install directory.
default['linux-dev-env']['android_sdk_install_dir'] = '/opt'

# Set Android user. CHANGE THIS!
default['linux-dev-env']['android_user'] = 'skywalker'

# Set Android group, CHANGE THIS!
default['linux-dev-env']['android_group'] = 'skywalker'

# Set Android SDK version.
default['linux-dev-env']['android_sdk_version'] = 'r20.0.3'

# Set Eclipse IDE  install directory.
default['linux-dev-env']['eclipse_ide_install_dir'] = '/opt'

# Set Eclipse IDE version.
default['linux-dev-env']['eclipse_ide_version'] = '4.2.1'

# Java version to install
default['linux-dev-env']['java_version'] = '6u37'

# Set Lua version to install
# Possible values: 5.1, 5.2
default['linux-dev-env']['lua_version'] = '5.2'

# Set to yes to install luakit
default['linux-dev-env']['install_luakit'] = 'no'

# Set to yes to install luarocks
default['linux-dev-env']['install_luarocks'] = 'no'

# Set to yes to install luasocket
default['linux-dev-env']['install_luasocket'] = 'no'
