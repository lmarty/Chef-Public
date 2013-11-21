name             "repos"
maintainer       "Stanislav Bogatyrev"
maintainer_email "realloc@realloc.spb.ru"
license          "Apache 2.0"
description      "Installs/Configures package repositories"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
recipe           "repos","Adds repos from 'repos' attribute"
recipe           "percona","Adds Percona Server repo"
recipe           "opscode-chef-10","Adds OpsCode Chef-10 repo"
recipe           "backports", "Adds Debian backports repo"
recipe           "jenkins-debian-glue", "Adds jenkins-debian-glue repo"
recipe           "deb-multimedia", "Adds Debian-Multimedia.org repo"
recipe           "virtualbox", "Adds Oracle's Debian repo for VirtualBox"
recipe           "iceweasel","Iceweasel from mozilla.debian.net"
recipe           "emacs-snapshot","Adds repos with emacs snapshots for Debian"
recipe           "debian","Debian mirrors"
recipe           "kitchen-pkg","Local Chef Kitchen repo"

version          "0.0.3"
%w{ ubuntu debian }.each do |os|
  supports os
end
depends "apt"
