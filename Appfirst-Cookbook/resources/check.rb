actions :create, :remove

attribute :script_name, :kind_of => String, :required => true
attribute :warning, :kind_of => Integer, :required => true
attribute :critical, :kind_of => Integer, :required => true
# Short, human readable description of your script. Ex: 'Check_Mongo_Connections'
# Only Alphanumerics and '-"_
attribute :command, :name_attribute => true, :kind_of => String, :required => true
attribute :options, :kind_of => String
