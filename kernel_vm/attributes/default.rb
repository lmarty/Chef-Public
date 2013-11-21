default[:kernel_vm][:bridge] = 'br0'
default[:kernel_vm][:boxes] = %w(
  https://github.com/downloads/chrisroberts/vagrant-boxes/precise-64.box
)
=begin
  https://github.com/downloads/chrisroberts/vagrant-boxes/centos62-64.box
  https://github.com/downloads/chrisroberts/vagrant-boxes/centos58-64.box
)
=end
default[:kernel_vm][:image_storage] = '/opt/kernel_vm'
default[:kernel_vm][:knife][:static_ips] = []
default[:kernel_vm][:knife][:static_range] = nil
default[:kernel_vm][:knife][:gateway] = nil
default[:kernel_vm][:knife][:netmask] = nil
default[:kernel_vm][:knife][:nameserver] = nil
