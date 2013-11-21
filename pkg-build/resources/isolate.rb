actions :build
default_action :build

attribute :attributes, :kind_of => Hash
attribute :run_list, :kind_of => Array, :required => true
attribute :container, :kind_of => String, :required => true
