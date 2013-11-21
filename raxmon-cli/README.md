Description
===========
* Installs the python-pip package in Debian and RedHat based systems, and then uses pip to install the Rackspace Cloud Monitoring client, raxmon-cli, via pip

* The full raxmon-cli source can be viewed at https://github.com/racker/rackspace-monitoring-cli

* For more info on Rackspace Cloud Monitoring please visit http://www.rackspace.com/cloud/cloud_hosting_products/monitoring/

* The Getting Started Guide for Rackspace Cloud Monitoring is avaialble at http://docs.rackspace.com/cm/api/cm-getting-started-latest/index.html
** This guide includes examples for using the raxmon-cli to view/create entities/checks/alarms

* The full API Developer Guide is available at http://docs.rackspace.com/cm/api/v1.0/cm-devguide/content/overview.html


Requirements
============
* python and python-pip (installed by this cookbook)

* A Rackspace cloud server username and api key to use the raxmon-cli

* If you want automatic credentials added to the raxmon-cli commands for the root user, an encrypted data_bag named rackspace must be created with an item called cloud.  
  * If you do not want to use the /root/.raxrc file to manage the credentials for root, skip the following section 

###Setting up the .raxrc file for automatic cloud login credentials for root
####If you already have an encrypted_data_bag_secret file created and pushed out to your chef nodes
* Create the new encrypted data_bag
knife data bag create --secret-file <LOCATION/NAME OF SECRET FILE>  rackspace cloud

* Make the json file opened look like the following, then save and exit your editor:
{
  "id": "cloud",
  "raxusername": "<YOUR CLOUD SERVER USERNAME",
  "raxapikey": "<YOUR CLOUD SERVER API KEY"
}

####If you are not currently using an encrypted_data_bag_secret file
* Create a new secret file
openssl rand -base64 512 | tr -d '\r\n' > /tmp/my_data_bag_key

* The /tmp/my_data_bag_key (or whatever you called it in the above step) needs to be pushed out to your chef nodes to /etc/chef/encrypted_data_bag_secret

* Create the new encrypted data_bag
knife data bag create --secret-file /tmp/my_data_bag_key rackspace cloud

* Make the json file opened look like the following, then save and exit your editor:
{
  "id": "cloud",
  "raxusername": "<YOUR CLOUD SERVER USERNAME",
  "raxapikey": "<YOUR CLOUD SERVER API KEY"
}



Attributes
==========
From encrypted data bag rackspace with item cloud:
* ['raxusername']
* ['raxapikey']

Usage
=====
####Using the .raxrc file
*Follow the steps under the Requirements section above to create the encrypted data bag for the .raxrc file
* As root user you can manage your Rackspace Cloud Monitoring settings via the raxmon-cli tools, see the description above for links to the documentation
  * If you do not set the .raxrc credentials, or you want to use raxmon-cli from a non-root user, you can still access the Rackspace Cloud Monitoring API by using the --username and --api-key options on your raxmon commands

#### Not using the .raxrc file
* Do not create the rackspace cloud encrypted databag item
* Access the Rackspace Cloud Monitoring API by using the --username and --api-key options on your raxmon commands
