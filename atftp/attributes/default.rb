

case platform
when "ubuntu"
  set[:tftpd][:dir]   = "/srv/tftp"
else
  set[:tftpd][:dir]  = "/var/lib/tftp"
end

default[:tftpd][:use_inetd]       = false
default[:tftpd][:timeout]         = 300
default[:tftpd][:retry_timeout]   = 5
default[:tftpd][:mcast_port]      = 1758
default[:tftpd][:mcast_addr]      = "239.239.239.0-255"
default[:tftpd][:mcast_ttl]       = 1
default[:tftpd][:maxthread]       = 100
default[:tftpd][:use_blksize]     = false
default[:tftpd][:verbose]         = 5
