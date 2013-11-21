sargrapho Cookbook
==================
The SarGraphO cookbook installs SarGraphO.  SarGraphO collects sar data, graphs it, and generates web pages to display the graphs.

Requirements
------------
SarGraphO works with the RedHat family of Linux distributions.

Attributes
----------

#### sargrapho::default

* `node['sargrapho']['rpm']` - The name of the RPM package to install.  Default: sargrapho-1.0.0-1.noarch.rpm
* `node['sargrapho']['rpm_url']` - The URL of the RPM package to install.  Default: https://github.com/jasonc/sargrapho/releases/download/v1.0.0/#{node['sargrapho']['rpm']}


Usage
-----
#### sargrapho::default

Just include `sargrapho` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[sargrapho]"
  ]
}
```

Contributing
------------

1. Fork the repository on [Github](https://github.com/jasonc/chef-sargrapho).

	`$ git clone git@github.com:jasonc/chef-sargrapho.git`

2. Create a named feature branch (like `add_component_x`)

3. Write your change

4. Write tests for your change (if applicable)

5. Run the tests, ensuring they all pass

6. Submit a Pull Request using Github


License and Authors
-------------------
Author:: Jason Cannon
