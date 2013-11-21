name             'netdev_eos'
maintainer       'Arista Networks'
maintainer_email 'sprygada@aristanetworks.com'
license          'Apache v2.0'
description      'Implements an EOS specific provider for netdev resources'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.1'

depends "netdev"

recipe "interface",
  "Manages physical interface resources on EOS based devices"
  
recipe "vlan",
  "Manages vlan resources on EOS based devices"

recipe "l2_interface",
  "Manages switchport resources on EOS based devices"
  
recipe "lag",
  "Manages lag (port-channel) resources on EOS based devices"

attribute 'netdev_config/databag_name',
  :display_name => 'Data Bag Name',
  :description => 'The name of the data bag to use for finding settings',
  :type => 'string',
  :required => 'required',
  :recipes => [ 'netdev_eos::vlan', 'netdev_eos::interface', 'netdev_eos::l2_interface', 'netdev_eos::lag' ],
  :default => 'netdev_config'
    
attribute 'netdev_config/providers/netdev_interface',
  :display_name => "Provider for netdev_interface LWRP",
  :description => "Sets the provider to use for implementing the LWRP",
  :type => "string",
  :required => "required",
  :recipes => [ 'netdev_eos::interface' ],
  :default => 'netdev_eos_interface'
  
attribute 'netdev_config/providers/netdev_vlan',
  :display_name => "Provider for netdev_vlan LWRP",
  :description => "Sets the provider to use for implementing the LWRP",
  :type => "string",
  :required => "required",
  :recipes => [ 'netdev_eos::vlan' ],
  :default => 'netdev_eos_vlan'
    
attribute 'netdev_config/providers/netdev_l2_interface',
  :display_name => "Provider for netdev_l2_interface LWRP",
  :description => "Sets the provider to use for implementing the LWRP",
  :type => "string",
  :required => "required",
  :recipes => [ 'netdev_eos::l2_interface' ],
  :default => 'netdev_eos_l2_interface'
      
attribute 'netdev_config/providers/netdev_lag',
  :display_name => "Provider for netdev_lag LWRP",
  :description => "Sets the provider to use for implementing the LWRP",
  :type => "string",
  :required => "required",
  :recipes => [ 'netdev_eos::lag' ],
  :default => 'netdev_eos_lag'
  
