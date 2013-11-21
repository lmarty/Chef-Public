emerald_express Cookbook
========================

Deploy small ruby application in a self-contain, environmentally friendly way.

Specify a path to deploy, this cookbook will help you to install all the ruby gems and application files within that path. No pollution to the server, easy to truncate, re-deploy and scale out.

Requirements
------------
 * Ruby 1.9
 * Rubygems
 * Bundler

#### packages

Attributes
----------

Usage
-----
#### emerald_express::example

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[emerald_express:example]"
  ]
}
```

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Ming Liu
