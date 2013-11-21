name             "asgard"
maintainer       "StudyBlue, Inc."
maintainer_email "sean@studyblue.com"
license          "Apache 2.0"
description      "Installs/Configures Netflix Asgard with Tomcat and Apache"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

%w{ centos fedora redhat scientific amazon }.each do |os|
  supports os
end

recipe "asgard::apache", "Installs and configures Netflix Asgard with Apache and Tomcat."
recipe "asgard::server", "Installs and configures Netflix Asgard with Tomcat."

depends "apache2"
depends "java"
depends "tomcat"

# == ASGARD ATTRIBUTES
#
attribute "asgard/war/url",
  :display_name => "URL for downloading Asgard war file",
  :type => "string",
  :required => "required"

attribute "asgard/war/checksum",
  :display_name => "SHA-256 checksum of the Asgard war file",
  :type => "string",
  :required => "required"

attribute "asgard/aws/accounts",
  :display_name => "Array of AWS account numbers",
  :description => "List of AWS account numbers to use within Asgard.",
  :type => "array",
  :required => "required"

attribute "asgard/aws/accountNames",
  :display_name => "Map AWS account numbers to names",
  :description => "Hash that maps AWS account numbers to human-readable names for display within Asgard.",
  :type => "hash",
  :required => "required"

attribute "asgard/aws/accountId",
  :display_name => "AWS account id",
  :description => "AWS account id that Asgard should use.",
  :type => "string",
  :required => "required"

attribute "asgard/aws/secretKey",
  :display_name => "AWS secret key",
  :description => "AWS secret key that Asgard should use.",
  :type => "string",
  :required => "required"

attribute "asgard/cloud/accountName",
  :display_name => "Name of primary account",
  :description => "Name of the primary AWS account. Should match entry in asgard.aws.accountNames.",
  :type => "string",
  :required => "required"

# == JAVA ATTRIBUTES
#
attribute "java/jdk/6/x86_64/url",
  :display_name => "URL for JDK 6",
  :description => "URL for downloading JDK 6 tar gzip file. Must be hosted privately. Cannot download from Oracle without a browser.",
  :type => "string",
  :required => "required"

attribute "java/jdk/6/x86_64/checksum",
  :display_name => "SHA-256 checksum for the JDK",
  :type => "string",
  :required => "required"

# == APACHE ATTRIBUTES
#
attribute "asgard/apache/server/admin",
  :display_name => "Apache administrator email address",
  :type => "string",
  :required => "optional"

attribute "asgard/apache/server/name",
  :display_name => "Apache server name",
  :type => "string",
  :required => "optional"

attribute "asgard/apache/server/aliases",
  :display_name => "Array of server aliases",
  :type => "array",
  :required => "optional"
