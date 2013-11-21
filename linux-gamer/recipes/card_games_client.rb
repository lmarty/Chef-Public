#
# Cookbook Name:: linux-gamer
# Recipe:: card_games_client 
#
# Copyright 2012, Gerald L. Hevener Jr., M.S.
#

# Install boat-load of card games available via
# apt-get for Debian based distros.
case node["platform"]
  when "debian","ubuntu","linuxmint"
    %w{ pokerth kpat aisleriot pysolfc pysolfc-cardsets lskat
	gnome-hearts xmahjongg python-poker2d gtali ace-of-penguins xmille holdingnuts
        pybridge }.each do |pkg|
     package pkg
  end
end
