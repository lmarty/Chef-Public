actions :install
attribute :cookbook, :kind_of => String
attribute :dirs, :kind_of => Array, :default => Array.new
attribute :document_root, :kind_of => String, :default => 'htdocs'
attribute :files, :kind_of => Array, :default => Array.new
attribute :group, :kind_of => String
attribute :install_base, :kind_of => String
attribute :install_prefix, :kind_of => String
attribute :install_version, :kind_of => String
attribute :local_source_dir, :kind_of => String
attribute :tarball, :kind_of => String
attribute :templates, :kind_of => Array, :default => Array.new
attribute :user, :kind_of => String
attribute :variables, :kind_of => Hash, :default => Hash.new
attribute :verbose, :kind_of => [TrueClass, FalseClass], :default => false
attribute :cleanup, :kind_of => [TrueClass, FalseClass], :default => false
attribute :make_access_rights, :kind_of => [TrueClass, FalseClass], :default => true


