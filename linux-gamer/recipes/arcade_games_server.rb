#
# Cookbook Name:: linux-gamer
# Recipe:: arcade_games_server 
#
# Copyright 2012, Gerald L. Hevener Jr., M.S.
#

# Install arcade game servers available via
# apt-get for Debian based distros.
case node["platform"]
  when "debian","ubuntu","linuxmint"
    %w{ teeworlds-server nexuiz-server openarena-server sauerbraten-server blobby-server
        warmux-servers liquidwar-server warsow-server alien-arena-server mmpongd }.each do |pkg|
     package pkg
  end
end
