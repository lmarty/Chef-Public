# DESCRIPTION:
The cookbook downloads SugarCRM Community Edition and configures SugarCRM's silent installer for easy installation. The user must go to http://server/sugarcrm/ to complete installation. 


# REQUIREMENTS:

# Opscode cookbooks

* mysql
* php
* apache2
* opensssl
* git

# Platforms

So far was tested on Ubuntu 10.04, but should work against any platform supported by Opscode apache2, php, and mysql cookbooks.


# ATTRIBUTES:
* sugar_crm[:admin_pass] - sets the admin password for SugarCRM instance (default is admin)
* sugar_crm[:dir] - Subdirectory to place sugarcrm files. Default is 'sugarcrm' under Apache's webroot (configured in Opscode apach2 cookbook)
* sugar_crm[:db][:database] - sugarcrm will use this MySQL database to store its data.
* sugar_crm[:db][:user] - sugarcrm will connect to MySQL using this user.
* sugar_crm[:db][:password] - Password for the sugarcrm MySQL user. The default is a randomly generated string.

The random generation is handled with the secure_password method in the openssl cookbook which is a cryptographically secure random generator and not predictable like the random method in the ruby standard library.

# USAGE:

Uses Opscode mysql, php, apache2 cookbooks to configure LAMP stack and git to checkout the latest stable build of SugarCRM CE. Cookbook just stages installation, setting values in config_si.php, so the first time the user hits  the instance installation will finish. 

Add the recipe to your node or role and let Chef do the rest.

Login to application using 'admin' username and password to create additional users. Default admin user's password can be overridden at the role or node level.

#Note
This cookbook requires php cookbook with version 1.2.6 or greater

# Author
Author:: NagaLakshmi (nagalakshmi.n@cloudenablers.com)

Copyright:: 2013 CloudEnablers

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.