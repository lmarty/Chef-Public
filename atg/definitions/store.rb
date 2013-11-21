define :store do
  
  if params[:slot].empty?
    raise "This definition in cookbook #{self.cookbook_name} requires a value for 'slot'"
  end
  
  ##Need to get instance name for directory
  instance_name = "#{params[:instance]}"
  atg_data_instance_dir = "#{node.atg.app_home}/ATG-Data/servers/#{instance_name}"
  atg_setting = node[:atg][params[:slot]]
  
  Chef::Log.info "Working on slot #{params[:slot]}"
  atg_setting = node[:atg][params[:slot]]
  
  
  ## Creating ClusterName.properties for Stores
  Chef::Log.info "========== Working on ClusterName.properties for in #{instance_name}"
  template "#{atg_data_instance_dir}/localconfig/atg/dynamo/service/ClusterName.properties" do
    source "ClusterName.properties.erb"
    mode 0644
    owner "#{node.atg.user}"
    group "#{node.atg.user}"
    variables :cluster_name => "production"
  end
  
  ## Creating ClientLockManager.properties for Store instance
  Chef::Log.info "========== Working on ClientLockManager.properties for in #{instance_name}"
  %w{
    ClientLockManager.properties
  }.each do |dir|
    template "#{atg_data_instance_dir}/localconfig/atg/dynamo/service/#{dir}" do
      source "environment/#{dir}.erb"
      mode 0644
      owner "#{node.atg.user}"
      group "#{node.atg.user}"
      variables(
        :lock_manager => "#{node.atg.store.lockmanager}",
        :lock_manager => "#{node.atg.store.lockmanager_b}",
        :lock_port  => "#{node.atg.store.lock_port}",
        :lock_port  => "#{node.atg.store.lock_port_b}",
        :use_lock  => "#{node.atg.store.use_lock}"
      )
    end
  end
  
  ## Creating ServerLockManager.properties for Store instance
  ## Should not use this if stores are clustered.
  if node[:atg][:cluster] == false
    Chef::Log.info "========== Working on ServerLockManager for in #{instance_name}"
    %w{
      ServerLockManager.properties
    }.each do |dir|
      template "#{atg_data_instance_dir}/localconfig/atg/dynamo/service/#{dir}" do
        source "environment/#{dir}.erb"
        mode 0644
        owner "#{node.atg.user}"
        group "#{node.atg.user}"
        variables(
          :lock_manager => "#{node.atg.store.lockmanager}",
          :lock_manager => "#{node.atg.store.lockmanager_b}",
          :lock_port  => "#{node.atg.store.lock_port}",
          :lock_port  => "#{node.atg.store.lock_port_b}",
          :use_lock  => "#{node.atg.store.use_lock}"
        )
      end
    end 
  end
  
  
  
end
