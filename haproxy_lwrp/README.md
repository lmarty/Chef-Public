Description
===========

Implementation free resource and provider to configure haproxy instances.  Example below is a very rough example, you can load settings from roles, environments, data bags and or recipes themselves (like below).  

Sometimes design changes, we don't want to rewrite a whole new recipe and template for each change that is not productive.

Changes
=======

## v2.0.0:

* Add Basic LWRP

Requirements
============

## Platform

Tested on Ubuntu 8.10 and higher.

## Cookbooks:

Usage
==================

See tests or `recipe/lwrp_example.rb` for working examples.

```ruby
frontend_temp=Array.new  
frontend_temp << {"name" => "http-in *:80", "acl" => "acl bob-acl path_beg /status\nacl bob-acl2 path_beg /status2 if bob-acl\n", "default_backend" => "www" }  
frontend_temp << {"name" => "https-in *:443", "default_backend" => "www" }  
backend_temp=Array.new  
backend_temp << { "name" => "www", "mode" => "http", "balance" => "leastconn" , "option" => "option httpclose\noption redispatch\noption httpchk GET / HTTP/1.1\\r\\nHost: wwww\noption redispatch\n", "other" => "check", "server" => ["172.29.11.3","172.29.11.4"], "start_port" => 80, "instance_count" => 1}  
backend_temp << { "name" => "https", "mode" => "tcp", "balance" => "leastconn" , "option" => "option httpclose\noption redispatch\noption httpchk GET / HTTP/1.1\\r\\nHost: wwww\noption redispatch\n", "other" => "check", "server" => ["127.0.0.1"], "maxconn" => 2, "start_port" => 443, "instance_count" => 1}  
backend_temp << { "name" => "unicorn", "mode" => "tcp", "balance" => "leastconn" , "option" => "option httpclose\noption redispatch\noption httpchk GET / HTTP/1.1\\r\\nHost: wwww\noption redispatch\n", "other" => "check", "server" => ["127.0.0.1"], "maxconn" => 20, "start_port" => 8080, "instance_count" => 1}  
backend_temp << { "name" => "manythins", "mode" => "tcp", "balance" => "leastconn" , "option" => "option httpclose\noption redispatch\noption httpchk GET / HTTP/1.1\\r\\nHost: wwww\noption redispatch\n", "other" => "check", "server" => ["127.0.0.1"], "maxconn" => 20, "start_port" => 3000, "instance_count" => 4}  
listen_temp=Array.new  
listen_temp <<   {"name" => "fart 0.0.0.0:22002", "mode" => "http", "stats" => "stats uri /"}  
include_recipe "haproxy::install"  
include_recipe "runit"  
haproxy_lwrp_lb "adserver" do  
frontend(frontend_temp)  
backend(backend_temp)  
listen(listen_temp)  
action :create  
end  
```

Another example 

```ruby
listen_temp=Array.new  
listen_temp << { "name" => "carbon-relay-plain 0.0.0.0:2003", "mode" => "tcp", "server" => ["127.0.0.1"], "start_port" => 2031, "instance_count" => 3}
listen_temp << { "name" => "carbon-relay-pickle 0.0.0.0:2004", "mode" => "tcp", "server" => ["127.0.0.1"], "start_port" => 2041, "instance_count" => 3}
haproxy_lwrp_lb "haproxy" do
  global({"maxconn" => 65535, "ulimit-n" => 160000, "user" => "haproxy", "group" => "haproxy", "stats" => "socket /var/run/haproxy.sock mode 0600 level admin user root" })
  defaults({ "log" => "global", "mode" => "http", "option" => "dontlognull", "balance" => "leastconn", "srvtimeout" => 60000, "contimeout" => 5000, "retries" => 3,"option" => "redispatch\noption contstats"})
  listen(listen_temp)
    action :create
end
```    

License and Author
==================

Author:: Scott M. Likens (<scott@likens.us>)

Copyright:: 2013, Scott M. Likens.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
