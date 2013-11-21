# packages to install for kvm tuning
case platform
when 'ubuntu', 'debian'
  default[:kvm][:host][:tuning][:packages] = %w(ebtables kvm-ipxe)
when 'centos', 'redhat', 'scientific'
  default[:kvm][:host][:tuning][:packages] = %w(ebtables gpxe-roms-qemu)
else
  raise 'unsupported platform'
end

default["kvm"]["host"]["tuning"]["ksm_enabled"] = true

