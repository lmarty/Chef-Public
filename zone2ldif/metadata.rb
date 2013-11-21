name             'zone2ldif'
maintainer       'Gerald L. Hevener Jr., M.S.'
maintainer_email 'jackl0phty@gmail.com'
license          'Apache 2.0'
description      'Installs/Configures zone2ldif'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

%w{ perl }.each do |ckbk|
  depends ckbk
end
