Description
===========
* Install the rsdns Rackspace Cloud DNS management scripts from github https://github.com/linickx/rsdns

* Puts the scripts into /opt/rsdns, a symlink to the main rsdns script into /usr/local/bin so it's in the PATH, and creates a .rsdns_config file in /root with the username and api key to use

Requirements
============

* A Rackspace cloud server username and api key to use the rsdns scripts

* If you want automatic credentials added to the rsdns commands for the root user, an encrypted data_bag named rackspace must be created with an item called cloud.  
  * If you do not want to use the /root/.rsdns_config file to manage the credentials for root, skip the following section 

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
####Using the .rsdns_config file
*Follow the steps under the Requirements section above to create the encrypted data bag for the .rsdns_config file
* As root user you can manage your Rackspace Cloud DNS settings via the rsdns tools, see the description above for links to the documentation
  * If you do not set the .rsdns_config credentials, or you want to use rsdns from a non-root user, you can still access the Rackspace Cloud DNS API by -u and -a options on your rsdns commands

#### Not using the .rsdns_config file
* Do not create the rackspace cloud encrypted databag item
* Access the Rackspace Cloud DNS API by using the -u and -a options on your rsdns commands
* Export the path to rsdns with "export RSPATH=/opt/rsdns", or add the export command to your .bash_profile
