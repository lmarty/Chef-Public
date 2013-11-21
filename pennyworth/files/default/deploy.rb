#
# Author:: Darrin Eden <darrin@heavywater.ca>
#
# Copyright 2011, Heavy Water Software Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# TODO: There are some EC2 assumptions here. We should be more generic.

module HeavyWater
  class Deploy < Chef::Knife

    banner "knife deploy QUERY"

    option :attribute,
    :short => "-a ATTR",
    :long => "--attribute ATTR",
    :description => "The attribute to use for opening the connection - default is fqdn",
    :default => "fqdn"

    option :force,
    :short => "-f",
    :long => "--force",
    :description => "Force a deploy"

    option :identity_file,
    :short => "-i IDENTITY_FILE",
    :long => "--identity-file IDENTITY_FILE",
    :description => "The SSH identity file used for authentication"

    option :ssh_user,
    :short => "-x USERNAME",
    :long => "--ssh-user USERNAME",
    :description => "The ssh username"

    deps do
      require "chef/shef/ext"
      require "chef/knife/ssh"
      require "net/ssh"
      require "net/ssh/multi"
      require "net/ssh/gateway"
    end

    def upgrade( node)
      unload( node)
      set_version( node)
      converge( "name:#{node.name}")
      smoke( node)
      load( node)
    end

    def run
      Shef::Extensions.extend_context_object(self)

      unless name_args.size == 1
        puts "You need to supply a query"
        show_usage
        exit 1
      end

      @query = name_args.first

      if ( new_version == old_version)
        puts "Latest version deployed to all nodes."
        exit unless config[:force]
      end

      if search( :node, query).length < 2
        puts "Two or more nodes required to support rolling deploys."
        exit unless config[:force]
      end

      # Remove reference to terminated nodes
      cleanup()

      # Upgrade nodes not in the load balancer; assuming failure
      unloaded.each { |node| upgrade( node) }

      # Upgrade the rest of the nodes
      search( :node, query).each { |node| upgrade( node) }
    end

    def query
      @query
    end

    def app
      query[/\w*$/]
    end

    def new_version
      # Version of the newest project artifact generated by CI
      data_bag_item( :package, app)["version"]
    end

    def old_version
      # Oldest version deployed on any node
      versions = search( :node, query).map { |node| node[app][:version] }
      versions.sort.first
    end

    def set_version( node)
      puts "setting version: #{new_version}"
      node.set[app][:version] = new_version
      node.save
    end

    def loaded_ips
      # List of IP addresses being load balanced
      data_bag_item( :pools, "load_balancers")["loaded_ips"]
    end

    def cleanup
      # Remove reference to terminated nodes
      lbs = data_bag_item( :pools, "load_balancers")
      node_ips = search( :node, query).map { |node| node[:ipaddress] }
      lbs["loaded_ips"] = ( lbs["loaded_ips"] & node_ips)
      lbs.save
    end

    def unloaded
      # List of nodes not being load balanced
      ips = loaded_ips
      search( :node, query).reject { |node| ips.include?( node[:ipaddress]) }
    end

    def load_balance( ips)
      # Update load balancer pool data bag
      item = Chef::DataBagItem.new
      item.data_bag( "pools")
      item.raw_data = { "id" => "load_balancers", "loaded_ips" => ips }
      item.save
    end

    def load( node)
      # Add a node to load balancer
      puts "loading: #{node.name}"
      load_balance( loaded_ips + [ node[:ipaddress]])
      converge( "role:lb")
    end

    def unload( node)
      # Remove a node from load balancer
      puts "unloading: #{node.name}"
      load_balance( loaded_ips - [ node[:ipaddress]])
      converge( "role:lb")
    end

    def smoke( node)
      # Smoke test a node to test and warm it
      puts "smoking: #{node.name}"

      # We're wanting to load a URI directly from the node.
      # Since it's
      # on EC2's internal network maybe something like this so
      # our
      # workstation is able to connect?

      # gateway = Net::SSH::Gateway.new(
      # node[:ec2][:public_ipv4], "ubuntu" )
      # gateway.open( node[:ec2][:ipaddress], 2999 ) do |port|
      #  Net::HTTP.get_print("127.0.0.1", "/", port)
      # end
      # gateway.shutdown!

      true
    end

    def converge( search_term)
      puts "converging: #{search_term}"
      knife_ssh = Chef::Knife::Ssh.new
      knife_ssh.config = config
      knife_ssh.config[:manual] = true
      cmd = "sudo /opt/ruby/bin/chef-client --log_level error"
      nodes = search( :node, search_term)
      servers = nodes.map { |n| n[:ec2][:public_ipv4] }.join(" ")
      knife_ssh.name_args = [servers, cmd]
      knife_ssh.run
      true
    end
  end
end