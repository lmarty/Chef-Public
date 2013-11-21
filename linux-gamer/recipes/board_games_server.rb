#
# Cookbook Name:: linux-gamer
# Recipe:: board_games_server 
#
# Copyright 2012, Gerald L. Hevener Jr., M.S.
#

# Install board game servers available via
# apt-get for Debian based distros.
case node["platform"]
  when "debian","ubuntu","linuxmint"
    %w{ pioneers-meta-server pyscrabble-server }.each do |pkg|
     package pkg
  end
end
