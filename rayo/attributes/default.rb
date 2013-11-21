include_attribute "prism"

default["prism"]["portAppMappings"]["rayo"]        =  [5060]

default["rayo"]["bindAddress"]                     =  node["ipaddress"]
default["rayo"]["gateway"]["artifact"]             =  "http://files.voxeolabs.net/rayo/rayo-gateway.b193.war"
default["rayo"]["gateway"]["checksum"]             =  "4a7769dcaa8da191e1338c394366b562012b5b932a990474553b42e359fa2b10"
default["rayo"]["node"]["artifact"]                =  "http://files.voxeolabs.net/rayo/rayo.b193.war"
default["rayo"]["node"]["checksum"]                =  "d053d3953e0e7596286535cb9cf5eaad2bff12d2af368e127b434afca6003320"
default["rayo"]["node"]["routes"]                  =  []
default["rayo"]["node"]["include_external_fqdn"]   =  true
default["rayo"]["gateway"]["routes"]               =  []
default["rayo"]["jolokia"]["remote"]               =  ["localhost","127.0.0.1"]
default["rayo"]["jolokia"]["commands"]             =  ["read","list","exec","version"]
default["rayo"]["maven"]                           =  "maven.voxeo.net"
default["rayo"]["gateway"]["internal"]             =  ['internal.tropo.local']
default["rayo"]["gateway"]["external"]             =  ['gw.tropo.local','192.168.1.33','localhost']

if Chef::Config["solo"]
  default["rayo"]["cluster"]                      =  false
  default["prism"]["cluster_peers"]               =  []
else
  default["rayo"]["cluster"]                      =  search(:node, "chef_environment:#{node.chef_environment} AND recipe:rayo\\:\\:gateway").empty?
  default["prism"]["cluster_peers"]               =  search(:node, "role:#{node.roles.include?('rayo_gateway') ? 'rayo_gateway' : 'rayo_node'} AND chef_environment:#{node.chef_environment} NOT name:#{node.name}")
end

default["rayo"]["local_domain"]                   =  node.name
default["rayo"]["cassandra"]["test_data"]         =  false
default["rayo"]["node"]["gateway"]                =  nil

default["rayo"]["node"]["domains"]                =  [ node["ipaddress"], node.name, node["hostname"] ]

default["rayo"]["gateway"]["domains"]             =  [ node["ipaddress"], node.name, node["hostname"] ]

