name             "owfs"
maintainer       "Alexey Noskov"
maintainer_email "alexey.noskov@gmail.com"
license          "MIT"
description      "Installs OWFS, a 1-wire filesystem."
long_description IO.read(File.join(File.dirname(__FILE__), "README.md"))
version          "0.1.0"

recipe "owfs",           "Set up owfs common data"
recipe "owfs::owserver", "Set up owserver"

supports "ubuntu"
