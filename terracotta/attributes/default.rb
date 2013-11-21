#
# Cookbook Name:: terracotta
# Attributes:: default
#

default["terracotta"]["version"] = "3.7.0"
default["terracotta"]["install_dir"] = "/opt/src"
default["terracotta"]["installer_archive"] = default["terracotta"]["installer_dir"] + "/terracotta-" + default["terracotta"]["version"] + ".tar.gz"
default["terracotta"]["home"] = default["terracotta"]["install_dir"] + "/terracotta-" + default["terracotta"]["version"]
default["terracotta"]["tims"] = { "vector" => "2.7.1", "tomcat-6.0" => "2.4.0", "tomcat-5.5" => "2.4.0", "tomcat-common" => "2.4.0", "session-common" => "2.4.0", "session-ui" => "2.4.0" }
default["terracotta"]["toolkits"] = { "1.6" => "5.0.0" }
