actions :fetch, :unpack, :symlink, :deliver, :dump_resource, :clean, :delete
attribute :url, :kind_of => String
attribute :user, :kind_of => String
attribute :group, :kind_of => [String,Integer]
attribute :base, :kind_of => String
attribute :pattern, :kind_of => String
attribute :override, :kind_of => [TrueClass,FalseClass], :default => true
