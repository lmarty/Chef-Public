#
# Cookbook Name:: linux-gamer
# Recipe:: board_games_client 
#
# Copyright 2012, Gerald L. Hevener Jr., M.S.
#

# Install boat-load of board games available via
# apt-get for Debian based distros.
case node["platform"]
  when "debian","ubuntu","linuxmint"
    %w{ kmahjongg pychess pioneers pioneers-console glchess xmahjongg grhino
        eboard eboard-extras-pack1 mah-jong bovo kiriki kreversi kfourinline
        gnome-mastermind ksquares kigo yahtzeesharp openyahtzee quarry
        cgoban gnugo qgo dreamchess kajongg xshisen kshisen fltk1.3-games
        ace-of-penguins xboard gnubg biloba pente brutalchess
        knights glaurung fruit gnudoq gtkatlantic asciijump pyscrabble
        gtkboard gomoku.app londonlaw gamazons }.each do |pkg|
     package pkg
  end
end
