maintainer 'Chris Roberts'
maintainer_email 'chrisroberts.code@gmail.com'
license 'Apache 2.0'
description 'Installs and configures red_unicorn'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.2'


# NOTE: Currently forcibly configured via bluepill. Options for
# upstart/runit to be added later
%w(bluepill).each do |dep_book|
  depends dep_book
end

