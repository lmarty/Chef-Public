name             "app_database"
maintainer       "BinaryBabel OSS"
maintainer_email "projects@binarybabel.org"
license          "Apache License, Version 2.0"

description      "Install and manage databases for applications."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))

version          "0.1.0"

depends          "unix_bin", ">= 0.2.7"
depends          "resource_masher", ">= 0.10.0"
depends          "run_action_now", ">= 0.1.0"
