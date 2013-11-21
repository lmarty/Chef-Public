maintainer       "Mark Hibberd"
maintainer_email "mark@hibberd.id.au"
license          "BSD3"
description      "package-driver: data-bag driven package installs."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.1"

supports "arch"
supports "freebsd"
supports "ubuntu"
supports "debian"
supports "centos"
supports "fedora"
supports "redhat"


recipe "package-driver", "data-bag driven package installs."
