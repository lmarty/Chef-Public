define :staging do
  
  if params[:slot].empty?
       raise "This definition in cookbook #{self.cookbook_name} requires a value for 'slot'"
  end
  
  ##Need to get instance name for directory
  instance_name = "#{params[:instance]}"
  atg_data_instance_dir = "#{node.atg.app_home}/ATG-Data/servers/#{instance_name}"
  atg_setting = node[:atg][params[:slot]]
  
  ## Add Staging static files
  Chef::Log.info "========== Working on staging specific static configs in #{atg_data_instance_dir}"
  remote_directory "#{atg_data_instance_dir}/localconfig" do
    source "staging"
    files_owner "#{node.atg.user}"
    files_group "#{node.atg.user}"
    files_mode "0644"
    owner "#{node.atg.user}"
    group "#{node.atg.user}"
    mode "0755"
  end
  
  ## Creating ClusterName.properties for staging
  Chef::Log.info "========== Working on ClusterName.properties for in #{instance_name}"
  template "#{atg_data_instance_dir}/localconfig/atg/dynamo/service/ClusterName.properties" do
    source "ClusterName.properties.erb"
    mode 0644
    owner "#{node.atg.user}"
    group "#{node.atg.user}"
    variables :cluster_name => "staging"
  end
  
  ## Creating ServerLockManager.properties for staging
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
        :lock_manager => "#{node.atg.staging.lockmanager}",
        :lock_port  => "#{node.atg.staging.lock_port}",
        :use_lock  => "#{node.atg.staging.use_lock}"
      )
    end
  end  
  
  ## Configure scenarioManager.xml definition file for staging
  Chef::Log.info "Working on scenarioManager.xml file in staging definition file for #{instance_name}"
  
  scenario_server = "localhost:" + "#{atg_setting[:drp_port]}"
  
  template "#{atg_data_instance_dir}/localconfig/atg/scenario/scenarioManager.xml" do
    source "environment/scenarioManager.xml.erb"
    mode 0644
    owner "#{node.atg.user}"
    group "#{node.atg.user}"
    variables(
      :pes => "#{scenario_server}",
      :ges => "#{scenario_server}"
    )
  end
  
  
  
end