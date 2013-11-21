module Helpers
  module RabbitMQ
    require 'chef/mixin/shell_out'
    include Chef::Mixin::ShellOut
#    include MiniTest::Chef::Assertions
#    include MiniTest::Chef::Context
#    include MiniTest::Chef::Resources

    def get_vhosts(vhost_name)
      shell_out("rabbitmqctl list_vhosts").stdout
    end

    def get_users(user_name)
      shell_out("rabbitmqctl list_users").stdout
    end

    def get_permissions_by_vhost(vhost_name)
      shell_out("rabbitmqctl list_permissions -p #{vhost_name}").stdout
    end
  end
end

