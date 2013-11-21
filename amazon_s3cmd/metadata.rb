name             'amazon_s3cmd'
maintainer       'Gerald L. Hevener Jr., M.S.'
maintainer_email 'jackl0phty@gmail.com'
license          'Apache 2.0'
description      'Installs/Configures amazon_s3cmd'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version "0.1.46"

%w{ magic_shell yum }.each do |cb|
  depends cb
end
