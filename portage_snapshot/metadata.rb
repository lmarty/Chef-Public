name             'portage_snapshot'
maintainer       'Erik Mackdanz'
maintainer_email 'erikmack@gmail.com'
license          'Affero GPL v3'
# homepage         'https://github.com/erikmack/chef-portage-snapshot'
description      'Install a portage snapshot from a remote HTTP server'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends          'portage'
supports         'gentoo'
