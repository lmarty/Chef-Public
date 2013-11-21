#
# Cookbook Name:: linux-gamer
# Recipe:: simulation_games_client 
#
# Copyright 2012, Gerald L. Hevener Jr., M.S.
#

# Install simulation games available via
# apt-get for Debian based distros.
case node["platform"]
  when "debian","ubuntu","linuxmint"
    %w{ supertuxkart simutrans oolite torcs billard-gl openbve lincity-ng flightgear
        micropolis gl-117 achilles acm }.each do |pkg|
     package pkg
  end
end
