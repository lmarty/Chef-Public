maintainer_email "ajay_pm@hotmail.com"
description      "Installs/Configures seyren"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.4"

supports 'ubuntu'


depends 'application', '>= 2.0.4'
%w{ graphite maven mongodb tomcat }.each do |cb|
  depends cb
end

suggests "apache2"
