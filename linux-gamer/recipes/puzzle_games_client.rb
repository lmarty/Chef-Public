#
# Cookbook Name:: linux-gamer
# Recipe:: puzzle_games_client 
#
# Copyright 2012, Gerald L. Hevener Jr., M.S.
#

# Install boat-load of puzzle games available via
# apt-get for Debian based distros.
case node["platform"]
  when "debian","ubuntu","linuxmint"
    %w{ golly gbrainy sgt-puzzles glotski numptyphysics gweled glines
        zaz gnomine palapeli pegsolitaire black-box lmarbles sudoku gnome-sudoku
        ksudoku colorcode gtans einstein enigma primrose tworld chipw berusky
        shisen.app kshisen kubrick kdiamond laby fillets-ng krank pipewalker
        kiki-the-nano-bot pathological mirrormagic gmult pathogen gtkballs
        pynagram ace-of-penguins fltk1.3-games fltk1.1-games tetzle xword gsoko
        hitori anagramarama gnubik gridlock.app gtkboard kdrill makedic
        blocks-of-the-undead jigzo gfpoken }.each do |pkg|
     package pkg
  end
end
