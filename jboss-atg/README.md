= DESCRIPTION:
JBoss-ATG - JBoss cookbook to accompany the ATG-Cookbook. This cookbook
was originally written by Bryan W. Berry under the apache v2.0 License.
and should only be used with the atg-cookbook. You can find Bryan's
version under the opscode community for general JBoss installations.

For more information about atg cookbook please see http://addolux.com/index.php/services/atg-cookbook

= REQUIREMENTS:

java 1.6

= ATTRIBUTES:

* default['jboss']['jboss_home']  default location for jboss
* default['jboss']['version'] default version to download
* default['jboss']['dl_url'] download url
* default['jboss']['jboss_user'] default jboss user
* default['jboss']['cglib_jar']  name of the cglib jar which needs to replace the one out of the box.


= USAGE:

Accept 

Author: Bryan W. Berry <bryan.berry@gmail.com>
License: Apache v2.0

Modified by John K. Larsen <john.larsen@addolux.com> to accommodate the ATG Cookbook.
Included download method to file storage for jboss eap and cglib.jar
Customized version of init_rhel.erb to accommodate ATG for multiple instance.
