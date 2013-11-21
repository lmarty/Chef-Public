Description
===========

This cookbook provides resources and providers to install and configure [Graphite](http://graphite.wikidot.com/) Web Interface under [virtualenv](http://pypi.python.org/pypi/virtualenv).  Currently supported resources:

* Graphite web (`web`)

Requirements
============

1. [carbon](http://github.com/damm/carbon/)
  Installs the **Carbon Cache** and **Carbon Relay** Services
2. [Upstart](http://upstart.ubuntu.com/)
  Pull requests accepted to support other init styles
3. [Python](http://github.com/opscode-cookbooks/python/)
  Provides virtualenv support and the pip provider
4. [Runit](http://github.com/opscode-cookbooks/runit/)
  Minimum version of 0.16.3

Recipes
============

default.rb
----------

The default recipe does absolutely nothing.  It is not intended to do anything 

example.rb
----------

Outdated example of using carbon/graphite with upstart.  Will update shortly to be right.

Resources and Providers
=======================

This cookbook provides one resource and the corresponding provider.

`web.rb`
-------------

Installs and Configured [Graphite Web](https://github.com/graphite-project/graphite-web) from [Pypi](http://pypi.python.org/pypi/graphite-web)

Actions:

* `install` - installs graphite-web
* `create` - configures graphite-web
* `start` - starts the graphite-web service
* `stop` - stops the graphite-web service
* `git` - install graphite-web from *stable sources*

Attribute Parameters:

* `graphite_stable_base_git_uri` - String - default - `https://github.com/graphite-project/`
* `graphite_stable_packages` - Hash - default - `{ "graphite-web" => "0.9.x", "whisper" => "0.9.x" }`
* `initial_data_template` - String - default -  `initial_data.json.erb`
* `python_interpreter` - String - default - `python2.7`
* `init_style` - String - default `upstart`
* `cookbook` - String - default - `graphite`
* `user` - String - default - `graphite`
* `group` - String - default - `graphite`
* `workers` - String - default - `node[:cpu][:total].to_i`
* `timeout` - Fixnum - default - `300`
* `backlog` - Fixnum - default - `655355`
* `listen_port` - Fixnum, - default - `8080`
* `listen_address` - String - default - `0.0.0.0`
* `cpu_affinity` - String
* `local_settings_template` - String - default `local_settings.py.erb`
* `web_template` - String - default `graphite-web.init.erb`
* `graphite_home` - String - default - `/opt/graphite`
* `graphite_packages` - Hash - default - `{ "graphite-web" => "0.9.10", "gunicorn" => "0.16.1", "Djan
go" => "1.3", "django-tagging" => "0.3.1", "simplejson" => "2.1.6", "Twisted" => "11.0.0", "python-memcached" => "1.47"
, "txAMQP" => "0.4", "pytz" => "2012b" }`
* `debug` - String - default `False`
* `time_zone` - String - default - `UTC`
* `log_rendering_performance, :kind_of => String, :default => "False"
* `log_cache_performance, :kind_of => String, :default => "False"
* `documentation_url` - String - Configures the `DOCUMENTATION_URL` in local_settings.py
* `smtp_server` - String - configures the `SMTP_SERVER` setting in local_settings.py
* `use_ldap_auth` - String - Not fully implemented, please use your own local_settings.py template if you require this behavior
* `database_engine` - String - default *sqlite3*
* `database` - Hash - default - `{ :name => 'graphite', :user => 'graphite', :password => String.new, :host => String.new, :port => 5432 }`
* `cluster_servers` - String 
* `memcache_hosts` - String
* `rendering_hosts` - String
* `remote_rendering` - String
* `standard_dirs` - String
* `carbonlink_hosts` - String
 

Usage
============

```cd chef-repo/cookbooks```  
```git submodule add git://github.com/damm/carbon.git```  
```git submodule add git://github.com/damm/graphite.git```  
```COOKBOOK=graphite_infra rake new_cookbook```  

* The cookbook named ``graphite_infra`` must depend on the *graphite* cookbook.

```graphite_web "my_graphite" do  ```  
```  action [:install,:config,:start]```   
```end```

License and Author
==================
Author:: Scott M. Likens <scott@spam.likens.us>

Copyright 2012, Scott M. Likens

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
  
