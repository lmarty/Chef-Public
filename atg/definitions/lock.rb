define :lock do
  
  if params[:slot].empty?
    raise "This definition in cookbook #{self.cookbook_name} requires a value for 'slot'"
  end
  
  ##Need to get instance name for directory
  instance_name = "#{params[:instance]}"
  lock_no = "#{params[:lockinfo]}"
  atg_data_instance_dir = "#{node.atg.app_home}/ATG-Data/servers/#{instance_name}"
  
  ## Add Lock Manager static files
  Chef::Log.info "Working on lock manager specific static configs in #{atg_data_instance_dir}"
  remote_directory "#{atg_data_instance_dir}/localconfig" do
    source "lock"
    files_owner "#{node.atg.user}"
    files_group "#{node.atg.user}"
    files_mode "0644"
    owner "#{node.atg.user}"
    group "#{node.atg.user}"
    mode "0755"
  end
  
  if lock_no == "lock2"
    ## Creating ServerLockManager.properties for secondary Lock Manager
    Chef::Log.info "========== Working on ServerLockManager for in #{instance_name} is #{lock_no}"
    template "#{atg_data_instance_dir}/localconfig/atg/dynamo/service/ServerLockManager.properties" do
      source "environment/ServerLockManager.properties.erb"
      mode 0644
      owner "#{node.atg.user}"
      group "#{node.atg.user}"
      variables(
        :lock_port  => "#{node.atg.lock2.lock_port}",
        :lock_manager_other => "#{node.atg.lock1.lockmanager}",
        :lock_port_other  => "#{node.atg.lock1.lock_port}"
      )
    end
  else
    ## Creating ServerLockManager.properties for Primary Lock Manager
    Chef::Log.info "========== Working on ServerLockManager for in #{instance_name} is #{lock_no}"
    template "#{atg_data_instance_dir}/localconfig/atg/dynamo/service/ServerLockManager.properties" do
      source "environment/ServerLockManager.properties.erb"
      mode 0644
      owner "#{node.atg.user}"
      group "#{node.atg.user}"
      variables(
        :lock_port  => "#{node.atg.lock1.lock_port}",
        :lock_manager_other => "#{node.atg.lock2.lockmanager}",
        :lock_port_other  => "#{node.atg.lock2.lock_port}"
      )
    end
  end

    
    
end
