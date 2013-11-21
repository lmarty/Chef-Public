Travis-ci status: [![Build Status](https://secure.travis-ci.org/jackl0phty/opschef-cookbook-linux-gamer.png?branch=master)](http://travis-ci.org/jackl0phty/opschef-cookbook-linux-gamer)


Description
===========

Primary objective of this cookbook: Install/configure open source games on the GNU/Linux platform.

Will probably focus on Debian/Ubuntu support since Linux Mint+Cinnamon is my gaming platform of choice.

Supported Platforms
===================

Debian, & Ubuntu.

Requirements
============

A GNU/Linux client.

Usage
=====

Install arcade games (clients).

Add the following to your run list to install arcade games (clients).
<pre><code>
"recipe[linux-gamer::arcade_games_client]"
</pre></code>

Install arcade games (servers).

Add the following to your run list to install arcade games (servers).
<pre><code>
"recipe[linux-gamer::arcade_games_server]"
</pre></code>

Install board games (clients).

Add the following to your run list to install board games (clients).
<pre><code>
"recipe[linux-gamer::board_games_client]"
</pre></code>

Install board games (servers).

Add the following to your run list to install board games (servers).
<pre><code>
"recipe[linux-gamer::board_games_server]"
</pre></code>

Install card games (clients).

Add the following to your run list to install card games (clients).
<pre><code>
"recipe[linux-gamer::card_games_client]"
</pre></code>

Install card games (servers).

Add the following to your run list to install card games (servers).
<pre><code>
"recipe[linux-gamer::card_games_server]"
</pre></code>

Install various game emulators.

Add the following to your run list to install various game emulators
<pre><code>
"recipe[linux-gamer::emulators]"
</pre></code>

Install puzzle games (clients).

Add the following to your run list to install puzzle games (clients).
<pre><code>
"recipe[linux-gamer::puzzle_games_client]"
</pre></code>

Install role playing games (RPG). (clients)

Add the following to your run list to install role playing games (RPG). (clients)
<pre><code>
"recipe[linux-gamer::rpg_games_client]"
</pre></code>

Install role playing games (RPG). (servers)

Add the following to your run list to install role playing games (RPG). (servers)
<pre><code>
"recipe[linux-gamer::rpg_games_servers]"
</pre></code>

Install simulation games (clients).

Add the following to your run list to install simulation games (clients).
<pre><code>
"recipe[linux-gamer::simulation_games_client]"
</pre></code>

Install WINE (Wine Is Not an Emulator).

Add the following to your run list to install role playing games (RPG). (clients)
<pre><code>
"recipe[linux-gamer::wine]"
</pre></code>

Attributes
==========

Note: By default, this cookbook doesn't install/configure anything.
Set to 'yes' to install all games supported by this cookbook.
<pre><code>
default['linux-gamer']['install_all'] = "no"
</pre></code>

Set to yes to install latest wine via apt-get
<pre><code>
default['linux-gamer']['install_wine'] = "no"
</pre></code>

This is set to latest version of wine
<pre><code>
default['linux-gamer']['latest_stable_wine'] = "1.4"
</pre></code>

Set to yes to install latest wine from source to /opt
<pre></code>
default['linux-gamer']['install_wine_from_source'] = "no"
</pre></code>

Install Open Arena client
<pre><code>
default['linux-gamer']['install_open_arena_client'] = "no"
</pre></code>

Install Open Arena server
</pre></code>
default['linux-gamer']['install_open_arena_server'] = "no"
</pre></code>

Install PVPGN client ( e.g. Player vs. Player Gaming Network )
<pre><code>
default['linux-gamer']['install_pvpgn_client'] = "no"
</pre></code>

Install PVPGN server ( e.g. Player vs. Player Gaming Network )
<pre><code>
default['linux-gamer']['install_open_arena_server'] = "no"
</pre></code>
