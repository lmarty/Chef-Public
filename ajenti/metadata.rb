name             	'ajenti'
maintainer       	'Egor Medvedev'
maintainer_email	'methodx@aylium.net'
license			'Apache 2.0'
description      	'Installs ajenti panel'
long_description 	IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          	"0.1.0"


%w{debian ubuntu centos}.each do |os|
	supports os
end

%w{apt yum}.each do |dep|
	depends dep
end