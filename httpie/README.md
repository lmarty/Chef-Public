httpie Cookbook
===============
This cookbook installs httpie 

https://github.com/jkbr/httpie

Requirements
------------
This cookbook requires a few other cookbooks. 

#### cookbooks 
python,
yum, 
build-essential 

Attributes
----------
TODO: List you cookbook attributes here.

e.g.
#### httpie::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['httpie']['version']</tt></td>
    <td>String</td>
    <td>Version of httpie</td>
    <td><tt>0.6.0</tt></td>
  </tr>
  <tr> 
    <td><tt>['httpie']['arch']</tt></td> 
    <td>String</td> 
    <td>Architecture of client machine</td> 
    <td><tt>kernel['machine'] =~ /x86_64/ ? "amd64" : "386" 
</table>

Usage
-----
#### httpie::default

Just include `httpie` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[httpie]"
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
Authors: Miguel Alex Cantu
