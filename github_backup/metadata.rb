name            "github_backup"
maintainer       "computerlyrik"
maintainer_email "chef-cookbooks@computerlyrik.de"
license          "Apache 2.0"
description      "backup your public github repos"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"
supports        "ubuntu"
depends         'git'
