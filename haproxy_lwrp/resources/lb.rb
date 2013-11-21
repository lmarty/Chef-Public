actions :create

attribute :cookbook, :kind_of => String, :default => "haproxy"
attribute :user, :kind_of => String, :default => "haproxy"
attribute :group, :kind_of => String, :default => "haproxy"
attribute :global, :kind_of => Hash, :default => { "maxconn" => 40960, "user" => "haproxy", "group" => "haproxy", "stats" => "socket /var/run/haproxy.sock mode 0600 level admin user root" }
attribute :defaults, :kind_of => Hash, :default => { "log" => "global", "mode" => "http", "option" => "dontlognull", "balance" => "leastconn", "srvtimeout" => 60000, "contimeout" => 5000, "retries" => 3,"option" => "forwardfor\noption httplog\noption dontlognull" }
attribute :frontend, :kind_of => Array
# frontend_temp << {"name" => "http-in *:80", "acl" => "acl adserver-local-true path_beg /local/adunit_context_update\nacl adserver-local-true path_beg /local/adunit_worker\nuse_backend adserver-local if adserver-local-true\n", "default_backend" => "www" }
attribute :backend, :kind_of => Array
#backend_temp << { "name" => "adserver", "mode" => "http", "balance" => "leastconn" , "option" => "option httpclose\noption redispatch\noption httpchk GET / HTTP/1.1\\r\\nHost: wwww\noption redispatch\n", "other" => "check", "server" => ["172.29.11.3","172.29.11.4"], "start_port" => 5000, "instance_count" 4}
attribute :listen, :kind_of => Array
# listen_temp << { "name" => "adserver", "bind" => "bind :80,:443\nbind /var/run/haproxy.sock user root mode 644 accept-proxy\n","stats" => "stats uri /stats"} 
# or lighter
# listen_temp << {"name" => "admin 0.0.0.0:22002", "mode" => "http", "stats" => "stats uri /"}
attribute :source, :kind_of => String, :default => "haproxy-lwrp.erb"

def initialize(*args)
  super
  @action = :nothing
end
