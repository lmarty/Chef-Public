actions :verify
default_action :verify

attribute :checksum, :kind_of => String
attribute :algorithm, :kind_of => String, :default => 'sha1'
