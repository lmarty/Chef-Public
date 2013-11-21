# sensu_client cookbook

A wrapper around the sensu cookbook to install & setup sensu-client on a node.

See [sensuapp.com](http://sensuapp.com/) for more information about Sensu.


# Requirements

**sensu cookbook** - [https://github.com/sensu/sensu-chef](https://github.com/sensu/sensu-chef)

You need a Sensu server to connect to - for this, see my [sensu_server cookbook](https://github.com/ichilton/chef_sensu_server).


# Usage

You can set any of the sensu attributes detailed [in the README for the sensu cookbook](https://github.com/sensu/sensu-chef/blob/master/README.md), but you really need to setup the rabbitmq attribute to connect to RabbitMQ on your Sensu server. The defaults are (at the time of writing) as follows:

```
[:sensu][:rabbitmq][:host] = 'localhost'
[:sensu][:rabbitmq][:port] = 5671
[:sensu][:rabbitmq][:vhost] = '/sensu'
[:sensu][:rabbitmq][:user] = 'sensu'
[:sensu][:rabbitmq][:password] = 'password'
```

If you are using SSL (recommended), you need to point the client at the same ssl certificates as the server is using.

If you used [my sensu_server cookbook](https://github.com/ichilton/chef_sensu_server) and ran the commands given and are using Chef Server, you should already have the sensu ssl data bag so do not need to do anything. If you are using Chef Solo or Vagrant, you will need to point your sensu client box at the same data bag.

If you are not using SSL (not recommended), you need to set [:sensu][:rabbitmq][:user_ssl] to false, as per the server.

Once you have the SSL certificates in place (or SSL disabled), include default recipe in your run list.

You can do this by including it as a dependancy (in metadata.rb) in your wrapper cookbook and using: include_recipe 'sensu_client', or by including sensu_client in a role or node's run list.

When running with Chef Server / Hosted Chef, i'd generally use a search to get the ip address of the monitoring server:

    monitoring_ips = search(:node, "role:monitoring").map { |n| n['ipaddress'] }

    if monitoring_ips.count > 0
      node.normal[:sensu][:rabbitmq][:host] = monitoring_ips.first
    end

    node.normal[:sensu][:rabbitmq][:password] = 'mysecretpasswordhere'

    include_recipe 'sensu_client'

When using Vagrant and Chef Solo, i'd set these as follows:

    chef.json = {
      :sensu => {
        :rabbitmq => {
          :host => '10.200.200.10',
          :password => 'mysecretpasswordhere',
        }
      }
    }


# Attributes

There are a few configurable attributes for this cookbook:

**[:sensu_client][:additional_attributes]** - a hash of additional attributes to supply for this node's sensu-client configuration.

**[:sensu_client][:sensu_plugin_version]** - a specific version number of sensu-plugin to install. Leave this unset or false to install the latest.

**[:sensu_client][:subscriptions]** - an array of subscriptions. This defaults to 'all' plus any roles the node has (eg: all, web).

You can also set any of the sensu attributes detailed [in the README for the sensu cookbook](https://github.com/sensu/sensu-chef/blob/master/README.md).

For example, if you wanted to turn off SSL (not recommend), then you could do this:

In a recipe:

    node.override[:sensu][:use_ssl] = false

In an attributes file:

    override[:sensu][:use_ssl] = false


# Recipes

**default** - install sensu and setup the sensu-client service.


# Author

Author:: Ian Chilton (<ian@ichilton.co.uk>)
