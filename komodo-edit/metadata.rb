name             'komodo-edit'
maintainer       'Rilindo Foster'
maintainer_email 'rilindo.foster@monzell.com'
license          'Apache 2.0'
description      'Installs/Configures komodo-edit'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.3'
supports         'windows'
depends          'windows', '>= 1.2.6'
{"ubuntu" => '12.04'}.each do |os,ver|
  supports os, ">= #{ver}"
  case os
    when 'ubuntu'
      depends 'apt'
  end
end
