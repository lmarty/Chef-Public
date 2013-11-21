fuse Cookbook
=============
Installs FUSE and associated clients, allowing mount file system in user space.

Requirements
------------
Supports Fedora and Ubuntu out of the support. It may support Debian. It mostly supports CentOS/RHEL with EPEL/Repoforge.

Attributes
----------

* `default['fuse']['package_name']`
    - package name. Defaults to `'fuse'`

The following clients are included within the following attributes:

*  `default['fuse']['clients']['sshfs']` 
    - allows ability to mount remote file system over ssh.
*   `default['fuse']['clients']['zip']`
    - mounts zip file as a file system.
* `default['fuse']['clients']['iso']`
    - mounts iso as a file sytem.
* `default['fuse']['clients']['encfs']`
    - mounts encrypted file system.
* `default['fuse']['clients']['smb']`
    - mounts samba/CIFS volumes.
    
Client names are different depending on operating system. See attributes/defaults.rb for more details.

More clients will be supported in the future.

Usage
-----
To install the core package, include `fuse` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[fuse]"
  ]
}
```

To include additional clients, add them as individual recipes:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[fuse]",
    "recipe[fuse::sshfs]",
    "recipe[fuse::zip]",
    "recipe[fuse::iso]",
    "recipe[fuse::encfs]",
    "recipe[fuse::smb]",
  ]
}
```

Contributing
------------
To contribute:

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Rilindo Foster