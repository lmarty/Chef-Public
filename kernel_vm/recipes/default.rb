%w(kvm libvirt-bin virtinst nbd-client).each do |pkg_name|
  package pkg_name do
    action :install
  end
end

package('build-essential'){ action :nothing }.run_action(:install)
package('libvirt-dev'){ action :nothing }.run_action(:install)

chef_gem 'ruby-libvirt' do
  action :install
end

# Store images
directory node[:kernel_vm][:image_storage] do
  action :create
  mode 0755
end

%w(boxes templates storage).each do |dir|
  directory File.join(node[:kernel_vm][:image_storage], dir) do
    action :create
    mode 0755
  end
end

unless(node[:kernel_vm][:boxes].empty?)
  include_recipe 'kernel_vm::box_expander'
end

if(node[:kernel_vm][:module])
  kvm_mod = node[:kernel_vm][:module]
else
  kvm_mod = case node.cpu['0'].vendor_id
  when 'GenuineIntel'
    'kvm-intel'
  when 'AuthenticAMD'
    'kvm-amd'
  else
    raise 'Please explicitly define module to load'
  end
end

execute "kernel_vm module load[#{kvm_mod}]" do
  command "modprobe #{kvm_mod}"
  not_if do
    begin
      node.modules.kvm
      true
    rescue ArgumentError
      false
    end
  end
end

cookbook_file '/usr/local/bin/knife_kvm' do
  source 'knife_kvm'
  mode 0755
end

directory '/etc/knife-kvm' do
  action :create
end

file '/etc/knife-kvm/config.json' do
  mode 0644
  content(
    JSON.pretty_generate(
      :addresses => {
        :static => node[:kernel_vm][:knife][:static_ips],
        :range => node[:kernel_vm][:knife][:range_ips]
      },
      :gateway => node[:kernel_vm][:knife][:gateway],
      :netmask => node[:kernel_vm][:knife][:netmask],
      :nameserver => node[:kernel_vm][:knife][:nameserver]
    )
  )
end
