# DESCRIPTION:

My *nix user environment.

# REQUIREMENTS:

Debian or Ubuntu preferred.

# ATTRIBUTES:

* `node["vslinko"]["user"]` - Name of my user. Default is `vyacheslav`.
* `node["vslinko"]["group"]` - Group of my user. By default as group name used
  `node["vslinko"]["user"]` attribute.
* `node["vslinko"]["home"]` - User home directory.
* `node["vslinko"]["public_key"]` - My public key.
* `node["vslinko"]["dotfiles"]` - Path to my dotfiles repo. Default is
  `git://github.com/vslinko/dotfiles.git`.
