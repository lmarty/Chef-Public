define :common_config do
  
  Chef::Log.info "========== Slot value in common_config #{params[:slot]}"
  
  if params[:slot].empty?
    raise "This definition in cookbook #{self.cookbook_name} requires a value for 'slot'"
  end
  
  Chef::Log.info "========== Working on common config #{params[:instance]}"
  
  ## Variable assignments for organization purposes.
  app_home = "#{node.atg.app_home}"
  instance_name = "#{params[:instance]}" ## Represents full server instance name such as store-b
  instance_type = "#{params[:thetype]}"  ## Represents just the type such as store, staging etc
  instance_home = "#{app_home}/server/#{instance_name}"
  atg_data_instance_dir = "#{node.atg.app_home}/ATG-Data/servers/#{instance_name}"
  atg_setting = node[:atg][params[:slot]]
  
  ## Configure ATG instance Configuration.properties
  Chef::Log.info "Working on Configuration.properties file in common_config for #{instance_name}"
  template "#{atg_data_instance_dir}/localconfig/atg/dynamo/Configuration.properties" do
    source "Configuration.properties.erb"
    mode 0644
    owner "#{node.atg.user}"
    group "#{node.atg.user}"
    variables(
      :https_port => "#{atg_setting[:https_port]}",
      :drp_port => "#{atg_setting[:drp_port]}",
      :http_port => "#{atg_setting[:http_port]}",
      :file_port => "#{atg_setting[:file_deploy_port]}",
      :rmi_port => "#{atg_setting[:rmi_port]}",
      :http_port => "#{atg_setting[:http_port]}",
      :cluster => "#{node.atg.cluster}",
      :instance_type => "#{instance_type}"
    )
  end
  
  ## Creating scenarioManager.xml definition file for Publishing
  if instance_type == "store" || instance_type == "ca"
    Chef::Log.info "========== Working on ScenarioManager definition files for #{instance_name}"
    template "#{atg_data_instance_dir}/localconfig/atg/scenario/scenarioManager.xml" do
      source "environment/scenarioManager.xml.erb"
      mode 644
      owner "#{node.atg.user}"
      group "#{node.atg.user}"
      variables(
        :pes => "#{node.atg.pes}",
        :ges => "#{node.atg.ges}"
      )
    end
  end

end