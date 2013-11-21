# Webserver attributes
default[:mediacore][:web_server][:type] = "nginx"
default[:mediacore][:web_server][:port] = "80"
default[:mediacore][:web_server][:server_name] = node[:hostname] 
default[:mediacore][:web_server][:client_max_body_size] = "1500M"
