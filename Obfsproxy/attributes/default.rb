case node['platform']
when "debian","ubuntu"
  default['obfsproxy']['packages'] = %w[ autoconf autotools-dev gcc git pkg-config libtool libevent-2.0-5 libevent-dev libevent-openssl-2.0-5 libssl-dev make ]
when "redhat","centos","scientific","amazon"
  default['obfsproxy']['packages'] = %w[ autoconf autotools-dev gcc git pkg-config libtool libevent-2.0-5 libevent-dev libevent-openssl-2.0-5 libssl-dev make ]
end
