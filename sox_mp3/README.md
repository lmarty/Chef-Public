sox_mp3 cookbook
================

Installs the [Sox](http://sox.sourceforge.net/) package with mp3 encoding/decoding support

Requirements
------------

#### Packages

- `apt` - sox_mp3 needs apt to install packages.

#### Plarform

This cookbook has only been tested on Ubuntu 12.04. Pull requests for other platforms are appreciated

Attributes
----------

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['sox_mp3']['version']</tt></td>
    <td>String</td>
    <td>The version of sox to use</td>
    <td><tt>14.3.2</tt></td>
  </tr>
  <tr>
    <td><tt>['sox_mp3']['source_folder']</tt></td>
    <td>String</td>
    <td>The folder where the source for sox will be downloaded to</td>
    <td><tt>/usr/src/build/14.3.2</tt></td>
  </tr>
</table>

Usage
-----
#### sox_mp3::default

Include `sox_mp3` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[sox_mp3]"
  ]
}
```

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
6. Submit a Pull Request using Github

License and Authors
-------------------

Authors: Gabriel Cebrian
Licensed under the MIT License
