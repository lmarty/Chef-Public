name             'media'
maintainer       'Kannan Manickam'
maintainer_email 'me@arangamani.net'
license          'Apache 2.0'
description      'Installs/Configures media'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          IO.read(File.join(File.dirname(__FILE__), 'VERSION')) rescue '1.1.0'

%w{ ubuntu debian redhat centos fedora scientific }.each do |os|
  supports os
end

depends 'nfs'
depends 'minidlna'

recipe 'media', 'Simply runs the media::mount_devices recipe'
recipe 'media::mount_devices', 'Mounts the specified media devices'
recipe 'media::setup_nfs_shares', 'Sets up the specified NFS shares'
recipe 'media::setup_minidlna', 'Sets up the minidlna server'
