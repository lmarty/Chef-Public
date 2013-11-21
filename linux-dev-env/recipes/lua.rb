#
# Cookbook Name:: linux-dev-env
# Recipe:: lua 
#
# Copyright 2012, Gerald L. Hevener Jr., M.S.
#

# Install lua package
case node['platform_family']
  when "debian"
    if node['linux-dev-env']['lua_version'] == '5.2'
      %w{ lua5.2 luadoc }.each do |pkg|
        package pkg
      end
    end

    if node['linux-dev-env']['lua_version'] == '5.1'
      %w{ lua5.1 luadoc }.each do |pkg|
        package pkg
      end
    end

    if node['linux-dev-env']['install_luakit'] = 'yes'
      %w{ luakit }.each do |pkg|
        package pkg
      end
    end

    if node['linux-dev-env']['install_luarocks'] = 'yes'
      %w{ luarocks }.each do |pkg|
        package pkg
      end
    end
    
    if node['linux-dev-env']['install_luasocket'] = 'yes'
      %w{ luasocket }.each do |pkg|
        package pkg
      end
    end
end
