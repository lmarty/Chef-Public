include_recipe "dhcp"
dhcp_subnet "foreman" do
  subnet "192.168.55.0"
  range "192.168.55.100 192.168.55.200"
  netmask "255.255.255.0"
  broadcast "192.168.1.255"
  options [
    "routers 192.168.55.1",
    "domain-name    \"#{node['foreman']['domain']}\"",
    "domain-name-servers  10.1.1.1, 8.8.8.8",
#    "log-servers    syslog",
#    "ntp-servers    ntp"
  ]
end
