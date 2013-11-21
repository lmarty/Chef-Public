#
# Cookbook Name:: linux-gamer
# Recipe:: card_games_server 
#
# Copyright 2012, Gerald L. Hevener Jr., M.S.
#

# Install card game servers available via
# apt-get for Debian based distros.
case node["platform"]
  when "debian","ubuntu","linuxmint"
    %w{ pokerth-server holdingnuts-server pybridge-server }.each do |pkg|
     package pkg
  end
end
