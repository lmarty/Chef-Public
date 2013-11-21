# sensu_server cookbook

A wrapper around the sensu cookbook to install & setup a sensu-server.

See [sensuapp.com](http://sensuapp.com/) for more information about Sensu.


# Requirements

**sensu cookbook** - [https://github.com/sensu/sensu-chef](https://github.com/sensu/sensu-chef)


# Usage

If you are using SSL (recommended), you need to have the ssl certificates in a databag. A script is provided [with the sensu-chef cookbook](https://github.com/sensu/sensu-chef/tree/master/examples/ssl) to do this.

If you are using Chef Server (or Hosted Chef), you should do this on your workstation (where knife is setup):

    git clone https://github.com/sensu/sensu-chef.git
    cd sensu-chef/examples/ssl
    ./ssl_certs.sh generate
    knife data bag create sensu
    knife data bag from file sensu ssl.json
    ./ssl_certs.sh clean

If you are using Chef Solo, you can follow the instructions above, but instead of the "knife data bag" commands, you should create a sensu directory under the directory you configured as "data_bag_path" in your solo.rb file and copy the ssl.json file into it. If you are using Chef Solo with Vagrant, you can set the data_bag_path using:

    config.vm.provision "chef_solo" do |chef|
      chef.data_bags_path = "data_bags"
    end

If you are not using SSL (not recommended), you need to set [:sensu][:rabbitmq][:user_ssl] to false (see below).

Once you have the SSL certificates in place (or SSL disabled), include default recipe in your run list.

You can do this by including it as a dependancy (in metadata.rb) in your wrapper cookbook and using: include_recipe 'sensu_server', or by including sensu_server in a role or node's run list.


# Attributes

You can set any of the sensu attributes detailed [in the README for the sensu cookbook](https://github.com/sensu/sensu-chef/blob/master/README.md).

For example, if you wanted to turn off SSL (not recommend), then you could do this:

In a recipe:

    node.override[:sensu][:use_ssl] = false

In an attributes file:

    override[:sensu][:use_ssl] = false


# Recipes

**default** - install rabbitmq, redis + sensu and setup the server, api and dashboard services.


# Author

Author:: Ian Chilton (<ian@ichilton.co.uk>)
