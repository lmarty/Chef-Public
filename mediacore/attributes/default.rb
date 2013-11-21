# User and Group to run mediacore as
default[:mediacore][:user] = "www-data"
default[:mediacore][:group] = "www-data"

# Basic config options 
default[:mediacore][:smtp_server] = "localhost"
default[:mediacore][:error_email_from] = "mediacore@localhost"
default[:mediacore][:email_to] = "you@yourdomain.com"
default[:mediacore][:host] = "0.0.0.0"
default[:mediacore][:port] = "8080"

# Mediacore default database attributes
default[:mediacore][:db_type] = "postgresql"
default[:mediacore][:db_user] = "mediacore"
default[:mediacore][:db_pass] = "mediacore"
default[:mediacore][:db_address] = "localhost"
default[:mediacore][:database] = "mediacore"
default[:mediacore][:sqlalchemy][:url] = "#{node[:mediacore][:db_type]}://#{node[:mediacore][:db_user]}:#{node[:mediacore][:db_pass]}@#{node[:mediacore][:db_address]}/#{node[:mediacore][:database]}"
default[:mediacore][:sqlalchemy][:echo] = "False" 
default[:mediacore][:sqlalchemy][:pool_recycle] = "3600"

# Basic Options
default[:mediacore][:version] = "0.10.0"
default[:mediacore][:dir] = "/usr/local/mediacore"
default[:mediacore][:data_storage_dir] = "#{node[:mediacore][:dir]}/data"
default[:mediacore][:venv] = "#{node[:mediacore][:dir]}/venv"
default[:mediacore][:git_repo] = "git://github.com/mediacore/mediacore-community.git"
default[:mediacore][:log_location] = "/var/log/mediacore"

# More advanced config options
default[:mediacore][:plugins] = [ "*" ] 

# uwsgi options
default[:mediacore][:uwsgi][:socket] = "/tmp/uwsgi-mediacore.sock"
default[:mediacore][:uwsgi][:master] = "true"
default[:mediacore][:uwsgi][:processes] = 5
