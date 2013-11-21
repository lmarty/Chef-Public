actions :create

attribute :login,       :kind_of => String, :name_attribute => true
attribute :home,        :kind_of => String
attribute :full_name,   :kind_of => String
attribute :email,       :kind_of => String
attribute :private_key, :kind_of => String
attribute :known_hosts, :kind_of => Array, :default => []

def initialize(*args)
  super
  @resource_name = :git_user
  @action = :create
end
