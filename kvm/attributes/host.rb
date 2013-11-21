# packages to install as kvm host
case platform
when 'ubuntu', 'debian'
  default[:kvm][:host][:packages] = %w(qemu-kvm libvirt-bin)
when 'centos', 'redhat', 'scientific'
  default[:kvm][:host][:packages] = %w(qemu-kvm libvirt)
else
  raise 'unsupported platform'
end
