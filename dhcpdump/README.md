dhcpdump Cookbook
=================
Installs dhcpdump, which is a wrapper tool for tcpdump that allows you to view DHCP requests and traffic in a more readable form.

Requirements
------------
It installs off from Ubuntu out of the box. For CentOS/RHEL, you will need the repoforge or RHEL repo.

Attributes
----------
* `['dhcpdump']['package_name']` - package name. Defaults to `dhcpdump`.

Usage
-----

Just include `dhcpdump` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[dhcpdump]"
  ]
}
```

For CentOS and RHEL, you will need to include the yum::repoforge and/or yum::epel as well. Note that if you installed
from Opscode, you may need to exclude chef in repoforge and epel's repo.

Contributing
------------
To contribute

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Rilindo Foster <rilindo.foster@monzell.com>
