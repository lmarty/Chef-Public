xrdp Cookbook
=============
Installs and starts up xrdp, a remote server service for Linux that relys on the RDP protocol. Future updates will involve managing the config file as well (assuming that I have time. :) )

Requirements
------------
Mininum requirements are Ubuntu 12.04 and Fedora 17. For those who wish to contribute, please use ChefSpec for unit testing.

Note that in some cases, the desktop may not comeup when you login. For those on Ubuntu, here is a possible fix:

http://askubuntu.com/questions/91657/blank-desktop-when-logging-in-via-xrdp

Attributes
----------
* `default['xrdp']['server']['pkg']`
    - The xrdp package. Defaults to `'xrdp'`
* `default['xrdp']['server']['svc']` = '
    - the service script. Defaults to `'xrdp'`
Usage
-----

Just include `xrdp` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[xrdp]"
  ]
}
```

Contributing
------------
To Contribute

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Rilindo Foster <rilindo.foster@monzell.com>