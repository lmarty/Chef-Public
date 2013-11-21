ipf_configure Cookbook
======================

This cookbook makes ipf rules 

Requirements
------------

### cookbooks

- ipf (modcloth-cookbooks@github)

### supports

- smartos


Usage
-----

1. add `ipf_configure::default` to your run_list before other cookbooks.
2. update array `node.set[:ipf][rules]` in each other recipies.
3. add `ipf_configure::merge` to your run_list after other cookbooks.

You can create rules in optional recipes using search or attributes your like.

### ipf_configure::default

This recipe sets empty arrays to `node[:ipf]` for initialize.

### ipf_configure::merge

This recipe creates `ipf.conf` file. The rules are set by some recipes in run_list.

Examples
----

see `recipes/example.rb`


Contributing
------------
TODO: (optional) If this is a public cookbook, detail the process for contributing. If this is a private cookbook, remove this section.

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: 
 - Yukihiko Sawanobori (HiganWorks LLC)

License: Apache2 License