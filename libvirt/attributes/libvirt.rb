# Unix socket group
default[:libvirt][:server][:sock][:group] = "libvirtd"

# libvirtd startup options
default[:libvirt][:server][:opts] = "-d"

# auth_tls options
default[:libvirt][:server][:vnc_listen] = "127.0.0.1"
default[:libvirt][:server][:vnc_tls_verify] = 1

