name             "mplayer"
maintainer       "Escape Studios"
maintainer_email "dev@escapestudios.com"
license          "MIT"
description      "Installs/Configures mplayer"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.6"

%w{ debian ubuntu }.each do |os|
supports os
end

depends "build-essential"
depends "yasm"
depends "subversion"
depends "git"

recipe "mplayer", "Installs mplayer."
recipe "mplayer::package", "Installs mplayer using packages."
recipe "mplayer::source", "Installs mplayer from source."