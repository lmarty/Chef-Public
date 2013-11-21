name             'mediacore'
maintainer       'Texas A&M'
maintainer_email 'jarosser06@arch.tamu.edu'
license          'MIT'
description      'Installs/Configures mediacore'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.2'
supports         'ubuntu', '= 12.04'

%w{ python nginx supervisor postgresql database }.each do |dep|
  depends dep
end
