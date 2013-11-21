# git-fs cookbook

Installs g2p/git-fs(https://github.com/g2p/git-fs).
Tested with Ubuntu 12.04.

# Requirements

Requires git to be installed.
I recommend adding the `git::default` recipe from opscode's [git cookbook](https://github.com/opscode-cookbooks/git).

# Attributes

See `attributes/default.rb`.
The defaults should be fine for most people.

# Recipes

The `git-fs::default` recipe compiles and installs `git-fs` to `/usr/local/bin`.

# Author

Author:: Andrew Fecheyr (<andrew@bedesign.be>)
