Mediacore Cookbook
==================
This cookbook installs and configures a mediacore server. 

Requirements
------------
This cookbook has currently only been tested with Ubuntu 12.04LTS.

#### cookbooks 
- `python` - https://github.com/opscode-cookbooks/python 
- `nginx` - https://github.com/opscode-cookbooks/nginx 
- `supervisor` - https://github.com/opscode-cookbooks/supervisor 
- `postgresql` - https://github.com/opscode-cookbooks/postgresql  
- `database` - https://github.com/opscode-cookbooks/database

Attributes
----------

#### mediacore::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['mediacore']['user']</tt></td>
    <td>String</td>
    <td>mediacore user</td>
    <td><tt>www-data</tt></td>
  </tr>
  <tr>
    <td><tt>['mediacore']['group']</tt></td>
    <td>String</td>
    <td>mediacore group</td>
    <td><tt>www-data</tt></td>
  </tr>
  <tr>
    <td><tt>['mediacore']['smtp_server']</tt></td>
    <td>String</td>
    <td>smtp server for mediacore to use</td>
    <td><tt>localhost</tt></td>
  </tr>
  <tr>
    <td><tt>['mediacore']['error_email_from']</tt></td>
    <td>String</td>
    <td>email mediacore uses for errors</td>
    <td><tt>mediacore@localhost</tt></td>
  </tr>
  <tr>
    <td><tt>['mediacore']['email_to']</tt></td>
    <td>String</td>
    <td>email mediacore sends errors to</td>
    <td><tt>you@yourdomain.com</tt></td>
  </tr>
  <tr>
    <td><tt>['mediacore']['host']</tt></td>
    <td>String</td>
    <td>host mediacore binds to</td>
    <td><tt>0.0.0.0</tt></td>
  </tr>
  <tr>
    <td><tt>['mediacore']['port']</tt></td>
    <td>String</td>
    <td>port mediacore binds to</td>
    <td><tt>8080</tt></td>
  </tr>
  <tr>
    <td><tt>['mediacore']['db_type']</tt></td>
    <td>String</td>
    <td>dbms to use for mediacore</td>
    <td><tt>postgresql</tt></td>
  </tr>
  <tr>
    <td><tt>['mediacore']['db_user']</tt></td>
    <td>String</td>
    <td>mediacore database user</td>
    <td><tt>mediacore</tt></td>
  </tr>
  <tr>
    <td><tt>['mediacore']['db_pass']</tt></td>
    <td>String</td>
    <td>mediacore database password</td>
    <td><tt>mediacore</tt></td>
  </tr>
  <tr>
    <td><tt>['mediacore']['db_address']</tt></td>
    <td>String</td>
    <td>database location</td>
    <td><tt>localhost</tt></td>
  </tr>
  <tr>
    <td><tt>['mediacore']['database']</tt></td>
    <td>String</td>
    <td>mediacore database</td>
    <td><tt>mediacore</tt></td>
  </tr>
  <tr>
    <td><tt>['mediacore']['sqlalchemy']['url']</tt></td>
    <td>String</td>
    <td>mediacore sqlalchemy url</td>
    <td><tt>postgresql://mediacore:mediacore@localhost/mediacore</tt></td>
  </tr>
  <tr>
    <td><tt>['mediacore']['sqlalchemy']['echo']</tt></td>
    <td>String</td>
    <td>sqlalchemy loging</td>
    <td><tt>False</tt></td>
  </tr>
  <tr>
    <td><tt>['mediacore']['sqlalchemy']['pool_recycle']</tt></td>
    <td>String</td>
    <td>sqlalchemy pool recycling time</td>
    <td><tt>3600</tt></td>
  </tr>
  <tr>
    <td><tt>['mediacore']['version']</tt></td>
    <td>String</td>
    <td>mediacore version to use</td>
    <td><tt>0.10.0</tt></td>
  </tr>
  <tr>
    <td><tt>['mediacore']['dir']</tt></td>
    <td>String</td>
    <td>where to install mediacore</td>
    <td><tt>/usr/local/mediacore</tt></td>
  </tr>
  <tr>
    <td><tt>['mediacore']['data_storage_dir']</tt></td>
    <td>String</td>
    <td>where to store data files such as uploads</td>
    <td><tt>/usr/local/mediacore/data</tt></td>
  </tr>
  <tr>
    <td><tt>['mediacore']['venv']</tt></td>
    <td>String</td>
    <td>mediacore virtualenv location</td>
    <td><tt>/usr/local/mediacore/venv</tt></td>
  </tr>
  <tr>
    <td><tt>['mediacore']['git_repo']</tt></td>
    <td>String</td>
    <td>mediacore git repo</td>
    <td><tt>git://github.com/mediacore/mediacore-community.git</tt></td>
  </tr>
  <tr>
    <td><tt>['mediacore']['log_location']</tt></td>
    <td>String</td>
    <td>mediacore log location</td>
    <td><tt>/var/log/mediacore</tt></td>
  </tr>
  <tr>
    <td><tt>['mediacore']['plugins']</tt></td>
    <td>String</td>
    <td>list of plugins for config file</td>
    <td><tt>*</tt></td>
  </tr>
  <tr>
    <td><tt>['mediacore']['uwsgi']['socket']</tt></td>
    <td>String</td>
    <td>mediacore socket for uwsgi</td>
    <td><tt>/tmp/uwsgi-mediacore.sock</tt></td>
  </tr>
  <tr>
    <td><tt>['mediacore']['uwsgi']['master']</tt></td>
    <td>String</td>
    <td>uwsgi is master</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['mediacore']['uwsgi']['processes']</tt></td>
    <td>String</td>
    <td>number of uwsgi processes</td>
    <td><tt>5</tt></td>
  </tr>
</table>

#### mediacore::web_server
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['mediacore']['web_server']['type']</tt></td>
    <td>String</td>
    <td>web server to use</td>
    <td><tt>nginx</tt></td>
  </tr>
  <tr>
    <td><tt>['mediacore']['web_server']['port']</tt></td>
    <td>String</td>
    <td>port to bind webserver to</td>
    <td><tt>80</tt></td>
  </tr>
  <tr>
    <td><tt>['mediacore']['web_server']['server_name']</tt></td>
    <td>String</td>
    <td>server_name to use for web server</td>
    <td><tt>node['hostname']</tt></td>
  </tr>
  <tr>
    <td><tt>['mediacore']['web_server']['client_max_body_size']</tt></td>
    <td>String</td>
    <td>max client body size</td>
    <td><tt>1500M</tt></td>
  </tr>
</table>

Usage
-----
#### mediacore::default

Just include `mediacore` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[mediacore]"
  ]
}
```

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors:

* Jim Rosser - jarosser06@arch.tamu.edu 
