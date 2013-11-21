name              "akibanserver"
maintainer        "Akiban Technologies"
maintainer_email  "posullivan@akiban.com"
license           "Apache 2.0"
description       "Install and configure the Akiban Server"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "0.1.7"
recipe            "akibanserver::default", "Runs everything needed"
recipe            "akibanserver::setup_repos", "Sets up the Akiban repositories."
recipe            "akibanserver::required_packages", "Installs required packages."
recipe            "akibanserver::install", "Installs the Akiban Server package."

%w{ debian ubuntu centos redhat }.each do |os|
  supports os
end

depends           "apt", "1.8.0"
# Akiban implements the postgresql protocol so psql is needed for tests
depends           "postgresql"
# we want to run with oracle's jre
depends           "java"

attribute "akiban/data_dir",
  :display_name => "Akiban Data Directory",
  :description => "Location where Akiban data is stored",
  :default => "/var/lib/akiban"

attribute "akiban/conf_dir",
  :display_name => "Akiban Conf Directory",
  :description => "Location of Akiban conf files",
  :default => "/etc/akiban"

