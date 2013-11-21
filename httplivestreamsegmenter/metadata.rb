name             "httplivestreamsegmenter"
maintainer       "Escape Studios"
maintainer_email "dev@escapestudios.com"
license          "MIT"
description      "Installs/Configures httplivestreamsegmenter"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.8"

%w{ debian ubuntu }.each do |os|
supports os
end

depends "build-essential"
depends "git"

recipe "httplivestreamsegmenter", "Installs httplivestreamsegmenter from source."