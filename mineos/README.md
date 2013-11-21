mineos Cookbook
===============

This cookbook installs and configures [mineos](http://codeemo.com). Refer to 
<http://codeemo.com/mineoswiki/index.php?title=Installing_MineOS> for further
information.

**CAUTION**: If you’re upgrading from 1.0.x (mineos 0.5) to 2.x.x (mineos 0.6), 
please

- backup your servers (e.g. create an archive via the web ui)
- remove mineos 0.5 or just setup a new host machine
- run mineos::default
- restore your servers (e.g. use the web ui to re-create them from archives)

Requirements
------------

#### OS
- potentially any debian-based
- written for and tested on Ubuntu

#### packages
- `chef` :) (≥11.6.0)

#### cookbooks
- `logrotate`

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
    <td><tt>['mineos']['group']</tt></td>
    <td>String</td>
    <td>the group to grant profile editing rights to</td>
    <td><tt>mineos</tt></td>
  </tr>
  <tr>
    <td><tt>['mineos']['basedir']</tt></td>
    <td>String</td>
    <td>base directory to checkout the mineos repo to</td>
    <td><tt>/srv/mineos</tt></td>
  </tr>
  <tr>
    <td><tt>['mineos']['repository']</tt></td>
    <td>String</td>
    <td>the git repo to install mineos from</td>
    <td><tt>https://github.com/hexparrot/mineos.git</tt></td>
  </tr>
  <tr>
    <td><tt>['mineos']['version']</tt></td>
    <td>String</td>
    <td>version to checkout from the git repo; can be any commit identifier (id, branch, tag, …)</td>
    <td><tt>master</tt></td>
  </tr>
  <tr>
    <td><tt>['mineos']['profile_fix']['enable']</tt></td>
    <td>Boolean</td>
    <td>whether to overwrite the standard <tt>profile.config</tt> with a patched 
    one to include base profiles for newly released minecraft versions</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['mineos']['profile_fix']['versions']</tt></td>
    <td>String[]</td>
    <td>versions to include in the profile fix</td>
    <td><tt>[]</tt></td>
  </tr>
  <tr>
    <td><tt>['mineos']['service']['enable']</tt></td>
    <td>Boolean</td>
    <td>whether to enable the webui and “start servers on boot” services</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['mineos']['config']['basedir']</tt></td>
    <td>String</td>
    <td>where to put minecraft server data</td>
    <td><tt>/var/games/minecraft</tt></td>
  </tr>
  <tr>
    <td><tt>['mineos']['config']['local']</tt></td>
    <td>String</td>
    <td>webui locale (currently, only <tt>en</tt> and <tt>nl</tt> seem to be 
    suported)</td>
    <td><tt>en</tt></td>
  </tr>
  <tr>
    <td><tt>['mineos']['config']['logfile']</tt></td>
    <td>String</td>
    <td>where to put the mineos log</td>
    <td><tt>/var/log/mineos.log</tt></td>
  </tr>
  <tr>
    <td><tt>['mineos']['config']['host']['address']</tt></td>
    <td>String</td>
    <td>IP address for the webui to listen on</td>
    <td><tt>0.0.0.0</tt> (all)</td>
  </tr>
  <tr>
    <td><tt>['mineos']['config']['host']['port']</tt></td>
    <td>int</td>
    <td>port for the webui to listen on</td>
    <td><tt>8080</tt></td>
  </tr>
  <tr>
    <td><tt>['mineos']['config']['ssl']['enable']</tt></td>
    <td>Boolean</td>
    <td>whether to enable SSL encryption for the webui</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['mineos']['config']['ssl']['generate']</tt></td>
    <td>Boolean</td>
    <td>whether to generate a self signed SSL cert for the webui</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['mineos']['config']['ssl']['cert']</tt></td>
    <td>String</td>
    <td>where the webui SSL cert is stored; do not change if self signed cert 
    generation is enabled</td>
    <td><tt>/etc/ssl/certs/mineos.crt</tt></td>
  </tr>
  <tr>
    <td><tt>['mineos']['config']['ssl']['key']</tt></td>
    <td>String</td>
    <td>where the webui SSL private key is stored; do not change if self signed 
    cert generation is enabled</td>
    <td><tt>/etc/ssl/certs/mineos.key</tt></td>
  </tr>
  <tr>
    <td><tt>['mineos']['config']['ssl']['ca']</tt></td>
    <td>String</td>
    <td>where the webui SSL cert ca is stored; do not change if self signed 
    cert generation is enabled</td>
    <td><tt>&lt;empty&gt;</tt></td>
  </tr>
  <tr>
    <td><tt>['mineos']['config']['ssl']['chain']</tt></td>
    <td>String</td>
    <td>where the webui SSL cert chain is stored; do not change if self signed 
    cert generation is enabled</td>
    <td><tt>&lt;empty&gt;</tt></td>
  </tr>
</table>

Usage
-----

Just include `mineos` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[mineos]"
  ]
}
```

Then, put all the users that should be granted full access to the webinterface 
into the `['mineos']['group']` group.

Contributing
------------

I am using nvie’s
[git branching model](http://nvie.com/posts/a-successful-git-branching-model/ 
"nvie.com: A successfull Git branichng model"). To contribute you should follow 
these steps:

0. Check if your proposed change is already implemented in the `develop` branch
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request against the `develop` branch using Github

License and Authors
-------------------

Authors: ka’imi <kaimi@kaimi.cc>
