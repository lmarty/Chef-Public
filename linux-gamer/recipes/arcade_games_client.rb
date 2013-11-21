#
# Cookbook Name:: linux-gamer
# Recipe:: arcade_games_client
#
# Copyright 2012, Gerald L. Hevener Jr., M.S.
#

# Install boat-load of arcade games available via
# apt-get for Debian based distros.
case node['platform']
  when "debian"
    %w{ teeworlds supertux nexuiz openarena frozen-bubble kobodeluxe frogatto
        sauerbraten neverball tumiki-fighters sdl-ball uqm blobby madbomber
        gunroar fretsonfire extremetuxracer neverputt kollision titanion
        sopwith ri-li warmux torus-trooper performous performous-tools liquidwar
        xgalaga xgalaga++ chromium-bsu viruskiller btanks scorched3d gltron
        kgoldrunner parsec47 gnujump maelstrom burgerspace kbreakout
        kapman biniax2 tuxpuck powermanga krank whichwayisup funnyboat solarwolf
        rrootage overgod mu-cade briquolo icebreaker epiphany triplane bloboats
        enemylines3 pangzero empcommand alien-arena blockattack pyracerz circuslinux
        nikwi ktron snake4 plee-the-bear monsterz pinball toppler a7xpg
        penguin-command kolf gnibbles noiz2sa dopewars xscorch holotz-castle
        holotz-castle-editor dodgindiamond2 freegish xwelltris koules vodovod
        trackballs orbital-eunuchs-sniper blobwars sandboxgamemaker criticalmass
        airstrike vectoroids monster-masher kspaceduel projectl
        kblocks bouncy njam val-and-rick tomatoes tatan xbill enemylines3
        enemylines7 defendguin ketm gnome-breakout cultivation gnobots2
        mmpong-gl oneisenough ii-esu balder2d bomber gravitywars zatacka
        kbounce balazar3-2d balazar3-3d balazarbrothers pacman luola luola-levels
        luola-nostalgy xscavenger xboing gemdropx }.each do |pkg|
     package pkg
  end
end
