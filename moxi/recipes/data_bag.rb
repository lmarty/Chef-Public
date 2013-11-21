include_recipe "moxi::install"

bag = node.moxi.bag_name

node.moxi.instances.each do |instance|
  instance_data = data_bag_item( bag, instance )
  Chef::Log.info "setting up #{instance}"
  moxi_instance instance do
    instance_data.each do |attribute,value|
      send(attribute, value) unless attribute == "id"
    end
  end
end
