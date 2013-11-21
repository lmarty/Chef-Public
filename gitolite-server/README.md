= DESCRIPTION:

Installs and configures Gitolite
Gitolite  is autoconfigured from "users" data bag. Users should have
"ssh_keys" attribute containing their public SSH keys, "gitolite_repos"
attribute with name or list of names of repositories with read_write
access, and "gitolit_repos_ro" with a name or a list of names of
repositories with read-only access.

= REQUIREMENTS:

* git
* ssh_known_hosts
* Users databag
* Gitolite databag -> is created if it doesnt exist (Server client needs admin rights otherwise create the DB yourself)
	{ "id" : "key",
	  "key_pri":"asdjadlfkgjalgjkalgjh.....",
	  "key_pub":"ssh-rsa asfadfgalgknagkl...."
	}
* Deploy key
* Git server node client is admin in chef ( if you dont want to create the gitolite DB)

= USAGE:

Installs the Gitolite cookbook on a server that will become your git server. 
It will setup the gitolite admin repository in /srv/gitolite/repositories
Everytime chef runs on the git server the cookbook will do the following:

*  Adds keys and repos if there is a new user added to an existing repository
   or it will create an new repository if it doesn't exist.
*  The Cookbook checks which repos to make or amend by using the users databag 
   and checking the attributes gitolite_repos or gitolite_repos_ro and adding the users
   with RW+ permissions or R permissions
*  The cookbook assumes that you use a deploy-key to deploy your code from the repositories.
   It therefore adds the apache user(cause we use this to deploy code to a LAMP stack)
   to every repo with the public key it grabs from the gitolite databag. 
   The private key can be copied to other servers and added to the apache
   user or it can be added to a custom cookbook that grabs the key from the gitolite databag.
*  It checks to see if there are users that can be added to the gitolite group which can also add
   to the admin repository.

Platform  Tested on Ubuntu 12.04 LTS

= EXAMPLE:
  
This is an example of a user .json file.

{
  "id":"admin",
  "ssh_keys":"ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAgEA..........."
  "password": "asdjhalkf....",
  "groups": [ "sysadmin","gitolite" ],
  "uid": 2001,
  "shell": "\/bin\/bash",
  "gitolite_repos": ["projectx","projecty","projectz"],
  "gitolite_repos_ro":["projecta","projectb","projectc"],
  "comment": "admin@localhost.com"
}

= TODO

The management of the gitolite databag needs to be made. The cookbook assumes an configures gitolite databag for the apache user key.
