name             'heidisql'
maintainer       'Thorsten Klein'
maintainer_email 'cookbooks@perlwizard.de'
license          "Apache 2.0" 
description      'Installs/Configures HeidiSQL'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.0'
supports         "windows"

depends "windows", ">= 1.2.6"