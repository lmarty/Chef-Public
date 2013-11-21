class Chef
  class Recipe
    def get_config()
      config_provider = node[:eos][:config][:provider]
      Chef::Log.info "My config provider is #{config_provider}"
     
      if config_provider == "databag"
        databag = node[:eos][:config][:databag]
        Chef::Log.info "My data bag is #{databag}"

        identifier = node[:eos][:config][:identifier]
        Chef::Log.info "Netdev identifer is #{identifier}"

        case identifier
          when "hostname"
            identity = node[:hostname]
          when "macaddress"
            identity = node[:eos][:version][:macaddress]
          when "serialnum"
            identity = node[:eos][:version][:serialnumber]
          when "model"
            identity= node[:eos][:version][:model]
        end
        Chef::Log.info "Netdev identity is #{identity}"

        config = data_bag_item(databag, identity)
        return config
      elsif config_provider == "other"
        return nil
      else
        Chef::Log.fatal "Unknown or unsupported config provider"
      end
    end
  end
end