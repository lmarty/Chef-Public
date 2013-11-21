x2go Cookbook
=============
This cook installs the x2go server and client - both of which replaces NX Server.

Requirements
------------
At this time, only CentOS and RHEL 6.0 are supported. Ubuntu support is coming in a week or so.

It requires sshfs, which in turn, requires fuse. You can use the following cookbook to install fuse:

https://github.com/rilindo/cookbook-fuse

It also requires a working ssh server. You may use the following to manage openssh if it isn't already:

https://github.com/opscode-cookbooks/openssh

In a future up, a dependency may be linked with the above cookbooks.

For testing, you will need FoodCritic to validate the code and ChefSpec to run the tests.


Attributes
----------
* `default['x2go']['server']['pkg']`
    - The name of the x2go server package. Defaults to `'x2goserver'`.
    
* `default['x2go']['server']['svc']`
    -  installs the x2gocleansessions, which clean up stale user sessions. Defaults to `'x2gocleansessions'`.
    
* `default['x2go']['client']['pkg']`
    - The client used to login to a running x2go server. Defaults to `'x2goclient'`.

* `default['x2go']['install_flavor']`
    - repository type, which in tern is also the name of the repo recipe. Effectively defaults to `'yum_repo'`.

Usage
-----

Just include `x2go` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[x2go]"
  ]
}
```

To install the server, include x2goserver:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[x2go]",
    "recipe[x2go::server]"
  ]
}
```

To include the client:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[x2go]",
    "recipe[x2go::client]"
  ]
}
```


Contributing
------------
To contribute:

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Rilindo Foster <rilindo.foster@monzell.com

TODO:

* Templatize the x2goserver.conf file.
* Add Ubuntu support.
