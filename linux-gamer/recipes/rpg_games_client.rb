#
# Cookbook Name:: linux-gamer
# Recipe:: rpg_games_client 
#
# Copyright 2012, Gerald L. Hevener Jr., M.S.
#

# Install RPG ( Role Playing Game ) games available via
# apt-get for Debian based distros.
case node["platform"]
  when "debian","ubuntu","linuxmint"
    %w{ beneath-a-steel-sky exult exult-studio freedroidrpg adonthell flight-of-the-amazon-queen
        ardentryst pq angband kildclient sandboxgamemaker mudlet balazarbrothers crossfire-client
        crossfire-doc balazar3-3d }.each do |pkg|
     package pkg
  end
end
