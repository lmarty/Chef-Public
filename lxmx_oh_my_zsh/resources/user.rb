actions [:ensure, :update]

attribute :login,          :kind_of => String, :name_attribute => true
attribute :home,           :kind_of => String
attribute :theme,          :kind_of => String,                  :default => 'alanpeabody'
attribute :plugins,        :kind_of => Array,                   :default => []
attribute :case_sensitive, :kind_of => [TrueClass, FalseClass], :default => false
attribute :autocorrect,    :kind_of => [TrueClass, FalseClass], :default => true

def initialize(*args)
  super
  @action = :ensure
end
