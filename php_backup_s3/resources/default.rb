actions :create, :delete
default_action :create

attribute :name, :kind_of => String, :name_attribute => true

attribute :backup_files, :kind_of => Array, :default => []
attribute :backup_files_prefix, :kind_of => String, :default => node["hostname"]
attribute :backup_dbs, :kind_of => Array, :default => []
