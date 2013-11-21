name		 "linux-gamer"
maintainer       "Gerald L. Hevener Jr., M.S."
maintainer_email "jackl0phty@gmail.com"
license          "Apache 2.0"
description      "Installs/Configures open source games on GNU/Linux."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.10"

%w{ apt }.each do |cb|
  depends cb
end

%w{ debian ubuntu }.each do |os|
  supports os
end
