ez-ipupdate Cookbook
====================
Installs the ez-ipdate service under Opscode Chef

Requirements
------------
Platforms: 
Tested on Fedora. May work on other Linux platforms.

Attributes
----------

* `['ez-ipupdate']['package_name']` - Package name. Defaults to `ez-ipupdate`.
* `['ez-ipupdate']['package_config']` - Location of config file. Defaults to `/etc/ez-ipdate/default`
* `['ez-ipupdate']['username']` - Provider user name. Defaults to `username`.
* `['ez-ipupdate']['password']` - Your DNS update provider password. Defaults to `password`.
* `['ez-ipupdate']['host']` - The hostname of your domain hosted at your DNS provider. Defaults to `host`.
* `['ez-ipupdate']['service-type']` - The name of your DNS provider. Defaults to `provider`.
* `['ez-ipupdate']['interface']` - The internet facing interface on your server or desktop. Defaults to `eth0`.

Usage
-----

Just include `ez-ipupdate` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[ez-ipupdate]"
  ]
}
```

And then override the attributes.

Contributing
------------
If you wish to contribute:

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Rilindo.Foster <rilindo.foster@monzell.com>
=======
cookbook-ez-ipupdate
====================
