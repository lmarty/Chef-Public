
case platform
when "redhat","centos","fedora","suse"
  set[:php][:conf_dir] = "/etc/php.d"
when "ubuntu","debian"
  set[:php][:conf_dir] = "/etc/php5/conf.d"
else
  set[:php][:conf_dir] = "/etc/php5/conf.d"
end

default[:php][:eaccelerator][:url] = "http://bart.eaccelerator.net/source/0.9.6.1/eaccelerator-0.9.6.1.tar.bz2"
default[:php][:eaccelerator][:checksum] = "32ccd838e06ef5613c2610c1c65ed228"
default[:php][:eaccelerator][:cache_dir] = "/var/cache/eaccelerator"
