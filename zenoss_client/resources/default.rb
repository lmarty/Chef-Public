
actions :add, :delete
default_action  :add

attribute :device_title, :kind_of => String, :name_attribute => true
attribute :api_host, :kind_of => String, :default => node['zenoss']['client']['server'] 
attribute :api_port, :kind_of => Integer, :default => node['zenoss']['client']['server_port']
attribute :api_user, :kind_of => String, :required => true
attribute :api_password, :kind_of => String, :required => true
attribute :api_protocol, :kind_of => String, :equal_to => ["http", "https"], :default => "http"
attribute :wait_for, :kind_of => Integer, :default => 0
attribute  :ip, :kind_of => String, :regex => /\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/, :default => node['ipaddress']
attribute :collector, :kind_of => String, :default => "localhost"
attribute :device_class, :kind_of => String, :default => "/Devices/Server"
attribute :comments, :kind_of => String, :default => ""

