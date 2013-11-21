#
# Cookbook Name:: rackspacecloudbackup
# Attributes:: default
#
# Copyright 2013, David Joos
#

package "wget"

case node[:platform]
    when "debian", "ubuntu"
      #step 1: get the agent
      #trust the GPG Key
      #this step is required to tell apt that you trust the integrity of the Rackspace Cloud Backup Agent's apt repository
      execute "rackspacecloudbackup-add-gpg-key" do
          command "wget -O - http://agentrepo.drivesrvr.com/debian/agentrepo.key | apt-key add -"
          notifies :run, "execute[rackspacecloudbackup-apt-get-update]", :immediately
          not_if "apt-key list | grep #{node[:rackspacecloudbackup][:repository_key]}"
      end

      #step 2: add the resource
      template "/etc/apt/sources.list.d/driveclient.list" do
          source "rackspacecloudbackup.list.erb"
          mode 0644
          notifies :run, "execute[rackspacecloudbackup-apt-get-update]", :immediately
      end

      #step 3: install the agent
      #update the local package list
      execute "rackspacecloudbackup-apt-get-update" do
          command "apt-get update"
          action :nothing
      end

      package "driveclient" do
          action :upgrade
          notifies :run, "execute[rackspacecloudbackup-configure]", :immediately
      end
    when "redhat", "centos", "fedora"
        #step 1: confirm directory & step 2: get the RPM
        remote_file "/etc/yum.repos.d/drivesrvr.repo" do
            source "http://agentrepo.drivesrvr.com/redhat/drivesrvr.repo"
            action :create_if_missing
        end

        #step 3: install the RPM
        yum_package "driveclient" do
          action :install
        end
end

#step 4: configure the bootstrap
execute "rackspacecloudbackup-configure" do
    command "driveclient -c -u #{node[:rackspacecloudbackup][:username]} -k #{node[:rackspacecloudbackup][:api_key]}"
    action :nothing
    notifies :restart, "service[rackspacecloudbackup]", :immediately
end

#step 5: start the agent & step 6: set the agent to start on boot
service "rackspacecloudbackup" do
    service_name "driveclient"
    supports :status => true, :start => true, :stop => true, :restart => true
    action [:enable, :start] #starts the service if it's not running and enables it to start at system boot time
end