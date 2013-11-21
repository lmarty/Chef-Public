#
# Cookbook Name:: backup-manager
# Attributes:: backup_manager

default[:backup_manager][:upload_method] = "none"
default[:backup_manager][:local_folder] = [ "/etc","/home" ]
default[:backup_manager][:archive_ttl]  = "7"