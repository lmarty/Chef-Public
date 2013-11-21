name             'teamforge'
maintainer       'Opscode, Inc.'
maintainer_email 'jdunn@opscode.com'
license          'Apache 2.0'
description      'Installs/Configures CollabNet TeamForge'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.1'

%w{dmg iptables yum}.each do |cb|
  depends cb
end
