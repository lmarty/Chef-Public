ovirt Cookbook
==============
The oVirt cookbook allows you to easily install oVirt engine and oVirt node with Chef.

oVirt is a virtualization management application. That means that you can use the oVirt management interface (the oVirt engine) to manage hardware nodes, storage and network resources, and to deploy and monitor virtual machines running in your data center. The ovirt module allows you to install the oVirt Engine (management host) and oVirt Node (hyperviser host) software on RedHat-based distros.

Requirements
------------
RHEL and CentOS hosts need to have EPEL configured in order to fulfill oVirt rpm dependencies.

### Supported Operating Systems
- CentOS
- RHEL
- Fedora

Attributes
----------

### default

* `node['ovirt']['ovirt_release_rpm_url']` - This setting can be used to override the default oVirt release RPM URL of http://ovirt.org/releases/ovirt-release-$OS.noarch.rpm.

* `node['ovirt']['ovirt_release_base_url']` - This setting can be used to override the default oVirt release base URL of http://ovirt.org/releases.

* `node['ovirt']['application_mode']` - This setting can be used to override the default oVirt application mode of both.  Valid options are both, virt, gluster.

* `node['ovirt']['storage_type']` - This setting can be used to override the default oVirt storage type of nfs.  Valid options are nfs, fc, iscsi, and posixfs.

* `node['ovirt']['organization']` - This setting can be used to override the default oVirt PKI organization of localdomain.

* `node['ovirt']['nfs_config_enabled']` - This setting can be used to override the default oVirt nfs configuration of true.  Valid options are true and false.

* `node['ovirt']['iso_domain_name']` - This setting can be used to override the default ISO Domain Name of ISO_DOMAIN.

* `node['ovirt']['iso_domain_mount_point']` - This setting can be used to override the default ISO Domain Mount Point of /var/lib/exports/iso.

* `node['ovirt']['admin_password']` - This setting can be used to override the default oVirt admin password of admin.

* `node['ovirt']['db_user']` - This setting can be used to override the default database user of engine.

* `node['ovirt']['db_password']` - This setting can be used to override the default database password of dbpassword.

* `node['ovirt']['db_host']` - This setting can be used to override the default database host of localhost.

* `node['ovirt']['db_port']` - This setting can be used to override the default database port of 5432.

* `node['ovirt']['firewall_manager']` - This setting can be used to override the default firewall manager.  The module uses iptables for RHEL and CentOS and firewalld for Fedora by default.  Valid options are iptables and firewalld.

* `node['ovirt']['answers_file']` - This setting can be used to override the default value of /var/lib/ovirt-engine/setup/answers/answers-from-chef.


Usage
-----

###Creating an oVirt Engine

To create an oVirt Engine include `ovirt::engine` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[ovirt::engine]"
  ]
}
```

The oVirt Engine is now up and running. You can log in to the oVirt Engine's web administration portal with the username admin in the internal domain.


###Creating an oVirt Node

To create an oVirt Node include `ovirt::node` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[ovirt::node]"
  ]
}
```

At this point, you are able to add the node to a host cluster using an oVirt Engine.


Contributing
------------

1. Fork the repository on [Github](https://github.com/jasonc/chef-ovirt).

	`$ git clone git@github.com:jasonc/chef-ovirt.git`

2. Create a named feature branch (like `add_component_x`)

3. Write you change

4. Write tests for your change (if applicable)

5. Run the tests, ensuring they all pass

6. Submit a Pull Request using Github


License and Authors
-------------------
Author:: Jason Cannon
