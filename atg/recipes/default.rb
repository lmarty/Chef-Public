#
# Cookbook Name:: atg
# Recipe:: default
#
# Copyright 2012, Addolux LLC
#
# Apache License, Version 2.0
#

## variable assignements.
app_user = "#{node.atg.user}"
app_home = "#{node.atg.app_home}"

## Create ATG-Data directory to store configs
%w{
ATG-Data
ATG-Data/servers
}.each do |dir|
    directory "#{node.atg.app_home}/#{dir}" do
    owner "#{app_user}"
    group "#{app_user}"
    mode "0755"
    action :create
    #not_if {File.exists?("#{node.atg.app_home}/ATG-Data")}
    end
  end

## Here we take apart the atg instance names from its letter to determine server and port groups.
node.atg.instances.each do |instance_name|
  instance_name.to_s
  instance_type, instance_slot = instance_name.split("-")
  Chef::Log.info "========== Instance type is #{instance_type}."  ## instance type here is store, staging, ca etc
  Chef::Log.info "========== Instance slot is #{instance_slot}."  ## instance slot is the a,b,c or d group
  Chef::Log.info "========== Instance name is #{instance_name}."  ## instance name here is the full server/domain name such as store-b
  
  ### Accommodate lock1 and lock2 using global variables.
  $lock_convert = instance_type
  $instance_name = instance_name
  lock_no = instance_type
  
  ## Below just strips out the number from the locks.
  if $lock_convert == "lock1" || $lock_convert == "lock2"
    $lock_convert = $lock_convert[0..-2]
    $instance_name = $lock_convert + "-" + instance_slot
  end
  
  ## Return to instance variables  
  instance_type = $lock_convert
  instance_name = $instance_name

   
  ## Create ATG-Data server directories to store configs
  Chef::Log.info "========== creating atg-data server directory for #{instance_name}"
  directory "#{node.atg.app_home}/ATG-Data/servers/#{instance_name}" do
    owner "#{node.atg.user}"
    group "#{node.atg.user}"
    mode "0755"
    action :create
    not_if {File.exists?("#{node.atg.app_home}/ATG-Data/servers/#{instance_name}")}
  end
  
  ## Create jboss instances based on default or all server
  cpdir = "default"
  cpdir = "all" if instance_type == "store" && node.atg.cluster == true 
  
  execute "copy server" do
    cwd "#{app_home}/server"
    command "cp -pr #{cpdir} #{instance_name}"
    action :run
  end
  
  ### create localconfig directorie
  atg_data_instance_dir = "#{node.atg.app_home}/ATG-Data/servers/#{instance_name}"
  Chef::Log.info "========== Creating basic atg config directories for #{instance_name} in #{atg_data_instance_dir}"
      directory "#{atg_data_instance_dir}/localconfig" do
      owner "#{node.atg.user}"
      group "#{node.atg.user}"
      mode "0755"
      action :create
      end
  
  ## Next up add static common configurations for store based instances
  Chef::Log.info "========== Starting on common static configs for #{instance_name} in #{atg_data_instance_dir}"
  if instance_type == "store" || instance_type == "aux" || instance_type == "stage" || instance_type == "lock"
    remote_directory "#{atg_data_instance_dir}/localconfig" do
      source "store_common"
      files_owner "#{node.atg.user}"
      files_group "#{node.atg.user}"
      files_mode "0644"
      owner "#{node.atg.user}"
      group "#{node.atg.user}"
      mode "0755"
    end
  end
  
  ## Configure instance specific configs
  Chef::Log.info "========== Starting on instances specific definitions passing values are #{instance_name}, #{instance_type} and #{instance_slot}"
  self.send(instance_type, "my-#{instance_name}-#{instance_slot}") do
     instance instance_name
     slot instance_slot
     lock_no lock_no
  end
  
  ## Configure common instance configs that include port information
  ## These configurations are configurations that are applied to all instances.
  ## like cluster name and configuration properties. Values are dynamic based on
  ## slot letter that determines port details.
  Chef::Log.info "========== Starting on common dynamic configs for #{instance_name}"
  common_config "my-ports-config" do
    instance instance_name
    slot instance_slot
    thetype instance_type  ## had to change type to thetype - chef doesn't like the word 'type'
  end
  
  ##JBOSS specific configurations.
  if node[:atg][:app_server] == "jboss"
    Chef::Log.info "========== Starting on common dynamic configs for #{instance_name}"
    jboss_config "my-jboss-config" do
      instance instance_name
      slot instance_slot
      thetype instance_type
    end
  end


  
end

