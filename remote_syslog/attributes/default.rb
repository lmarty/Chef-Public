default.remote_syslog.init_style = "init"
default.remote_syslog.conf.files = ["/var/log/*.*"]
default.remote_syslog.destination.host = "logs.papertrailapp.com"
default.remote_syslog.destination.port = 12345

# Unused
default.remote_syslog.tcp = false
default.remote_syslog.tls = false
