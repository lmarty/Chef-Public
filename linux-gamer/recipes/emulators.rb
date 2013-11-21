#
# Cookbook Name:: linux-gamer
# Recipe:: emulators 
#
# Copyright 2012, Gerald L. Hevener Jr., M.S.
#

# Install game emulators available via
# apt-get for Debian based distros.
case node["platform"]
  when "debian","ubuntu","linuxmint"
    %w{ visualboyadvance visualboyadvance-gtk }.each do |pkg|
     package pkg
  end
end
