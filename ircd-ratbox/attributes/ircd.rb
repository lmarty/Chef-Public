default[:ircd][:name] = node[:fqdn]
default[:ircd][:ip] = node[:ipaddress]
default[:ircd][:description] = "Example server"
default[:ircd][:network_name] = "Example network"
default[:ircd][:network_description] = "Example network description"
default[:ircd][:port] = "6667"
default[:ircd][:motd] = "Nothing to see here, move along"
default[:ircd][:admin][:name] = "Example admin"
default[:ircd][:admin][:email] = "admin@example.com"

# For the below config variables all attributes are required!
default[:ircd][:auth][:classes] = [{"name" => "users", "ping_time" => "2 minutes",
"number_per_ident" => "2", "number_per_ip" => "3", "number_per_ip_global" => "5", "cidr_bitlen" => "64", "number_per_cidr" => "4", "max_number" => "100", "sendq" => "100 kbytes"}]
default[:ircd][:auth][:class_mapping] = [{"user" => "*@*", "class" => "users"}]
