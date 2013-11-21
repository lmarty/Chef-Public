Description
===========

This Chef cookbook deploys naglite2, which is a full screen nagios viewer intended for NOC/monitoring screens. 
Naglite2 is hosted here: https://github.com/lozzd/Naglite2

This has only been tested on Ubuntu 10.04.
 
Requirements
============
* Apache 2
* PHP
* tar

Attributes
==========
* `node[:naglite2][:dir]` - Where you want naglite2 to be installed
* `node[:naglite2][:repo_url]` - Where is the tarball hosted
* `node[:naglite2][:cgi_cfg]` - Where is the Nagios CGI config file located
* `node[:naglite2][:htpasswd]` - Where is the htpasswd located
* `node[:naglite2][:server_admin]` - What is the email to be populated inside the vhost
* `node[:naglite2][:server_name]` - Your server name, like naglite2.mydomain.com

Usage
=====

Just load `recipe[naglite2]` inside your role, and override attributes accordingly, like:

`"naglite2" => {
  "server_admin" => "noc@company.com",
  "server_name"  => "naglite2.company.com"
}`