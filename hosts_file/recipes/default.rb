# Default again just in case things have changed

node.default[:hosts_file][:fqdn] = node[:fqdn]
node.default[:hosts_file][:hostname] = node[:hostname]

# Always manage ourself
hosts_file_entry '127.0.0.1' do
  hostname node[:hosts_file][:fqdn]
  aliases [node[:hosts_file][:hostname], 'localhost']
end

node[:network][:interfaces].each do |name, info|
  next unless info[:type] == 'eth'
  info[:addresses].each do |address, a_info|
    if(a_info[:family] == 'inet')
      hosts_file_entry address do
        hostname node[:hosts_file][:fqdn]
        aliases [node[:hosts_file][:hostname]]
      end
    end
  end
end

template "managed_hosts_file" do
  source 'hosts.erb'
  path node[:hosts_file][:path]
  mode 0644
  action :nothing
end

ruby_block "hosts_file_notifier" do
  block do
    true
  end
  notifies :create, 'template[managed_hosts_file]', :delayed
end

# Add IPv6 bits
hosts_file_entry '::1' do
  hostname 'ip6-localhost'
  aliases %w(ip6-loopback)
end

hosts_file_entry 'fe00::0' do
  hostname 'ip6-localnet'
end

hosts_file_entry 'ff00::0' do
  hostname 'ip6-mcastprefix'
end

hosts_file_entry 'ff02::1' do
  hostname 'ip6-allnodes'
end

hosts_file_entry 'ff002::2' do
  hostname 'ip6-allrouters'
end
