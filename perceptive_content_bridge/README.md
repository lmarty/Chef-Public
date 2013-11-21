perceptive_content_bridge Cookbook
==================================
This cookbook installs the Perceptive Content Bridge web service.

Requirements
------------
Platform:
  - Ubuntu 12.04

Cookbooks:
TBD
  - chef_handler?
  - java?
  - tomcat?
  - windows?

Attributes
----------

none (yet).

Recipes
-------

  - Default - does nothing yet.

Usage
-----
#### perceptive_content_bridge::default

Just include `perceptive_content_bridge` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[perceptive_content_bridge]"
  ]
}
```

License and Authors
-------------------
Authors:
  Marc Kleinschmidt
  John Morford
  Jeremy Gustine
  Paul Mills

