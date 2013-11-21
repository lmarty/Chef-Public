define :ca do
  
  if params[:slot].empty?
       raise "This definition in cookbook #{self.cookbook_name} requires a value for 'slot'"
  end
  
  ##Need to get instance name for directory
  instance_name = "#{params[:instance]}"
  atg_data_instance_dir = "#{node.atg.app_home}/ATG-Data/servers/#{instance_name}"
    
  ## Add ca/publishing static files
  Chef::Log.info "Working on CA specific static configs in #{atg_data_instance_dir}"
  remote_directory "#{atg_data_instance_dir}/localconfig" do
    source "ca"
    files_owner "#{node.atg.user}"
    files_group "#{node.atg.user}"
    files_mode "0644"
    owner "#{node.atg.user}"
    group "#{node.atg.user}"
    mode "0755"
  end
  
  ## Creating ClusterName.properties for publishing
  Chef::Log.info "========== Working on ClusterName.properties for in #{instance_name}"
  template "#{atg_data_instance_dir}/localconfig/atg/dynamo/service/ClusterName.properties" do
    source "ClusterName.properties.erb"
    mode 0644
    owner "#{node.atg.user}"
    group "#{node.atg.user}"
    variables :cluster_name => "management"
  end
  
  ## Creating LockManager.properties for Publishing
  Chef::Log.info "========== Working on ServerLockManager and ClientLockManager.properties for in #{instance_name}"
  %w{
    ServerLockManager.properties
    ClientLockManager.properties
  }.each do |dir|
    template "#{atg_data_instance_dir}/localconfig/atg/dynamo/service/#{dir}" do
      source "environment/#{dir}.erb"
      mode 0644
      owner "#{node.atg.user}"
      group "#{node.atg.user}"
      variables(
        :lock_manager => "#{node.atg.ca.lockmanager}",
        :lock_port  => "#{node.atg.ca.lock_port}",
        :use_lock  => "#{node.atg.ca.use_lock}"
      )
    end
  end
  
  ## Creating store and staging ClientLockManager.properties for Publishing
  Chef::Log.info "========== Working on ClientLockManager.properties for targets in #{instance_name}"
  if node[:atg][:use_staging] == true
    targets = ["production", "staging"]
  else
    targets = ["production"]
  end
  
  targets.each do |target|
    template "#{atg_data_instance_dir}/localconfig/atg/dynamo/service/ClientLockManager_#{target}.properties" do
      source "environment/ClientLockManager_#{target}.properties.erb"
      mode 0644
      owner "#{node.atg.user}"
      group "#{node.atg.user}"
      variables(
        :cluster  => "#{node.atg.cluster}",
        :lock_store_manager => "#{node.atg.store.lockmanager}",
        :lock_store_manager_b => "#{node.atg.store.lockmanager_b}",
        :lock_store_port  => "#{node.atg.store.lock_port}",
        :lock_store_port_b  => "#{node.atg.store.lock_port_b}",
        :use_store_lock  => "#{node.atg.store.use_lock}",
        :lock_staging_manager => "#{node.atg.staging.lockmanager}",
        :lock_staging_port  => "#{node.atg.staging.lock_port}",
        :use_staging_lock  => "#{node.atg.staging.use_lock}"
      )
    end
  end
  
  ## Creating scenarioManager.xml definition file for Publishing
  Chef::Log.info "========== Working on internalScenarioManager definition files for #{instance_name}"
  template "#{atg_data_instance_dir}/localconfig/atg/scenario/internalScenarioManager.xml" do
    source "environment/internalScenarioManager.xml.erb"
    mode 644
    owner "#{node.atg.user}"
    group "#{node.atg.user}"
    variables :ism => "#{node.atg.ism}"
  end
  
  ## Creating workflowProcessManager.xml definition file for Publishing
  Chef::Log.info "========== Working on workflowProcessManager.xml definition file #{instance_name}"
  template "#{atg_data_instance_dir}/localconfig/atg/epub/workflow/process/workflowProcessManager.xml" do
    source "environment/workflowProcessManager.xml.erb"
    mode 644
    owner "#{node.atg.user}"
    group "#{node.atg.user}"
    variables :workflow => "#{node.atg.workflow_manager}"
  end
  
end