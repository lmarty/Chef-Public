Cookbook-ajenti
========================
Installs Ajenti panel everyone wants.

Requirements
------------

apt<br />
yum<br />
<br />
Debian 6-7<br />
CentOS 6

Usage
-----
#### cookbook-ajenti::default

Just include `cookbook-ajenti` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[cookbook-ajenti]"
  ]
}
```

Repository
----------

http://github.com/methodx/cookbook-ajenti

License
-------

Author: Egor Medvedev (<methodx@aylium.net>)