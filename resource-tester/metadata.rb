name             "resource-tester"
maintainer       "Sean OMeara"
maintainer_email "someara@opscode.com"
license          "Apache 2"
description      "Exercises core Chef resource across platforms"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.4"

supports 'centos'
depends 'minitest-handler'
