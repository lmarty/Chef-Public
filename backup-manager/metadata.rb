maintainer       "Efactures"
maintainer_email "nacer.laradji@gmail.com"
license          "Apache 2.0"
description      "Installs/Configures backup-manager"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.0.2"
recipe           "backup-manager", "Backup-manager configuration"

supports          "ubuntu", ">= 8.04"
supports          "debian", ">= 4.0"