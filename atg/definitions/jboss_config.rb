define :jboss_config do
  
    if params[:slot].empty?
      raise "This definition in cookbook #{self.cookbook_name} requires a value for 'slot'"
    end
  
    Chef::Log.info "========== Working on jboss #{params[:instance]}"
  
    ## Variable assignments for organization purposes.
    app_home = "#{node.atg.app_home}"
    instance_name = "#{params[:instance]}" ## Represents full server instance name such as store-b
    instance_type = "#{params[:thetype]}"  ## Represents just the type such as store, staging etc
    instance_home = "#{app_home}/server/#{instance_name}"
    log_path = "#{instance_home}/log"
    atg_data_instance_dir = "#{node.atg.app_home}/ATG-Data/servers/#{instance_name}"
    atg_setting = node[:atg][params[:slot]]
    atg_types = node[:atg][params[:thetype]]

    ## Configure jboss binding port
    Chef::Log.info "========== Working on jboss binding ports in jboss_config for #{instance_name}"
    template "#{instance_home}/conf/bindingservice.beans/META-INF/bindings-jboss-beans.xml" do
        source "jboss/bindings-jboss-beans.xml.erb"
        mode 0644
        owner "#{node.atg.user}"
        group "#{node.atg.user}"
        variables(
          :port_preset => "#{atg_setting[:port_preset]}"
        )
    end
  
    ## Configure log4j
    Chef::Log.info "========== Working on jboss log4j in jboss_config for #{instance_name}"
    template "#{instance_home}/conf/jboss-log4j.xml" do
        source "jboss/jboss-log4j.xml.erb"
        mode 0644
        owner "#{node.atg.user}"
        group "#{node.atg.user}"
        variables :log_priority => "#{node.atg.log_priority}"
    end
  
    ## Configure run.conf file for each instance
    Chef::Log.info "========== Working on jboss run.conf in jboss_config for #{instance_name}"
    template "#{instance_home}/run.conf" do
        source "jboss/run.conf.erb"
        mode 0644
        owner "#{node.atg.user}"
        group "#{node.atg.user}"
        variables(
            :xms => "#{node.atg.xms}",
            :xmx => "#{node.atg.xmx}",
            :max_perm => "#{node.atg.max_perm}",
            :threadstack => "#{node.atg.threadstack}",
            :logpath => "#{log_path}",
            :server => "#{instance_name}",
            :remote_port => "#{atg_setting[:jmx_remote]}",
            :liveconfig => "#{node.atg.liveconfig}",
            :modules => "#{atg_types[:module_list]}"
        )
    end
    
    ## Add oracle jdbc driver.
    Chef::Log.info "========== Uploading #{node.atg.ojdbc} to lib for #{instance_name}"
    remote_file "#{instance_home}/lib/#{node.atg.ojdbc}" do
        source "#{node.atg.dl_url}/#{node.atg.ojdbc}"
        owner "#{node.atg.user}"
        group "#{node.atg.user}"
        mode 0755
    end
    
    ## Configure transaction time out for agents
    if instance_type == "store"
        Chef::Log.info "========== Working on transaction time out in jboss_config for #{instance_name}"
        template "#{instance_home}/deploy/transaction-jboss-beans.xml" do
            source "jboss/transaction-jboss-beans.xml.erb"
            mode 0644
            owner "#{node.atg.user}"
            group "#{node.atg.user}"
            variables :transaction_timeout => "#{node.atg.transaction_timeout}"
        end
    end
    
    ## The following configurations use values from data bags.
    ## Assign which jboss data bags to use based on environment and instance type such as dev-store   
    data_bag_name = node.chef_environment + "-" + instance_type
    app_data = data_bag_item('jboss', "#{data_bag_name}" )
    
    ## Configure jmx console security for custom user and pass.
    ## This is needed for the jboss init startup script so you don't want to disable.
    Chef::Log.info "========== Working on jmx-console-users security in jboss_config for #{instance_name}"
    template "#{instance_home}/conf/props/jmx-console-users.properties" do
        source "jboss/jmx-console-users.properties.erb"
        mode 0644
        owner "#{node.atg.user}"
        group "#{node.atg.user}"
        variables(
            :user => app_data['jmx-user'],
            :pass => app_data['jmx-pass']
        )
    end
        
    ## Configure jboss datasources for each instance.
    #atg-#{instance_type>-ds.xml
        Chef::Log.info "========== Working on datasources in jboss_config for #{instance_name}"
        template "#{instance_home}/deploy/atg-#{instance_type}-ds.xml" do
            source "jboss/atg-ds.xml.erb"
            mode 0644
            owner "#{node.atg.user}"
            group "#{node.atg.user}"
            variables(
                :orahost => app_data['oracle_host'],
                :oraport => app_data['oracle_port'],
                :sid => app_data['oracle_sid'],
                :sn => app_data['oracle_sn'],
                :jndi => app_data['jndi-name']
            )
        end  
  
end
