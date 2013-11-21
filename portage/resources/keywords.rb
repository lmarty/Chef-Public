actions :add, :remove

attribute :entry, :kind_of => String, :name_attribute => true

def initialize(*args)
  super
  @action = :add
end
