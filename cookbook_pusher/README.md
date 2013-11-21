cookbook_pusher Cookbook
===============

alpha 

automagically pushes your github repos to opscode community site

##Github Repository Naming
name your repositories according to your prefix 
e.g. chef-my_cookbook

##Github Repository Description metadata
end your repository description with "| Category : my category"

Requirements
------------

* github account
* opscode account


Attributes
----------
#### cookbook_pusher::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['cookbook_pusher']['opscode_name']</tt></td>
    <td>String</td>
    <td>your opscode username</td>
    <td></td>
  </tr>
  <td><tt>['cookbook_pusher']['authkey']</tt></td>
    <td>Hash</td>
    <td>your opscode auth key</td>
    <td></td>
  </tr>
  <tr>
    <td><tt>['cookbook_pusher']['github_name']</tt></td>
    <td>String</td>
    <td>your github username</td>
    <td></td>
  </tr>
  <tr>
    <td><tt>['cookbook_pusher']['prefix']</tt></td>
    <td>String</td>
    <td>prefix for naming of your github repository</td>
    <td>chef-</td>
  </tr>
  <tr>
</table>

Usage
-----
#### cookbook_pusher::default

Just include `cookbook_pusher` in your node's `run_list`:


Contributing
------------
.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: TODO: List authors
