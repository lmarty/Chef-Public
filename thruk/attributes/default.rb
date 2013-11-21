
default["thruk"]["version"] = "1.72-2"

default["thruk"]["dir"] = "/usr/share/thruk"
default["thruk"]["docroot"] = "/usr/share/thruk/root/thruk"
default["thruk"]["log_dir"] = "/var/log/thruk"
default["thruk"]["conf_dir"] = "/etc/thruk"
default["thruk"]["htpasswd"] = "/etc/thruk/htpasswd"
default["thruk"]["use_ssl"] = false

default["thruk"]["cert_name"] = node["fqdn"]
default["thruk"]["cgi"]["admin_group"] = "admins"
default["thruk"]["cgi"]["read_groups"] = "all"


default['thruk']['first_day_of_week'] = 1
default['thruk']['start_page'] = "/thruk/main.html"

default['thruk']['cmd_defaults']['ahas'] = 0
default['thruk']['cmd_defaults']['broadcast_notification'] = 0
default['thruk']['cmd_defaults']['force_check'] = 0
default['thruk']['cmd_defaults']['force_notification'] = 0 
default['thruk']['cmd_defaults']['send_notification'] = 1
default['thruk']['cmd_defaults']['sticky_ack'] = 1
default['thruk']['cmd_defaults']['persistent_comments'] = 1
default['thruk']['cmd_defaults']['persistent_ack'] = 0
default['thruk']['cmd_defaults']['ptc'] = 0
default['thruk']['cmd_defaults']['use_expire'] = 0
