actions :create, :delete
default_action :create

attribute :name, :kind_of => String, :name_attribute => true
attribute :cookbook, :kind_of => String, :default => "incron"

attribute :path, :kind_of => String
attribute :mask, :kind_of => String
attribute :command, :kind_of => String
