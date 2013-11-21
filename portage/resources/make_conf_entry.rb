actions :replace, :remove

attribute :entry, :kind_of => String, :name_attribute => true
attribute :value, :kind_of => String

def initialize(*args)
  super
  @action = :replace
end
