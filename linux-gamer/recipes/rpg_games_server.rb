#
# Cookbook Name:: linux-gamer
# Recipe:: rpg_games_server 
#
# Copyright 2012, Gerald L. Hevener Jr., M.S.
#

# Install RPG ( Role Playing Game ) game servers available via
# apt-get for Debian based distros.
case node["platform"]
  when "debian","ubuntu","linuxmint"
    %w{ crossfire-server crossfire-maps-small }.each do |pkg|
     package pkg
  end
end
