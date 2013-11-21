nrpe_config_dir="/usr/share/appfirst/plugins/etc"
nrpe_config="#{nrpe_config_dir}/nrpe_appfirst.cfg"
nrpe_scripts_dir="/usr/share/appfirst/plugins/libexec"

action :create do 

# For now we cheat at put everything as the 'ubuntu' user, this should really depend on the platform.

  [nrpe_config_dir, nrpe_scripts_dir].each do |dir|
    directory dir do
      owner "ubuntu"
      group "ubuntu"
      mode "0755"
      action :create
      recursive true
    end
  end

  cookbook_file "#{nrpe_scripts_dir}/#{new_resource.script_name}" do
    # Sourced from the calling cookbook
    source "#{new_resource.script_name}"
    owner 'ubuntu'
    group 'ubuntu'
    notifies :restart, resources(:service => "afcollector")
    mode 0755
  end

  # For now we limit to one check per script name
  execute "add check #{new_resource.script_name}" do
    command "echo 'command[#{new_resource.command}]=#{nrpe_scripts_dir}/#{new_resource.script_name} #{new_resource.options} -w #{new_resource.warning} -c #{new_resource.critical}' >> #{nrpe_config}"
    # Delayed action avoids the chicken/egg issue if the collector is not installed yet.
    notifies :restart, resources(:service => "afcollector")
    not_if "cat #{nrpe_config} | grep -- #{new_resource.script_name}" 
  end

  # Bad hack to make sure everything should be accessible, another ubuntu specific section
  execute "Enforce Ownership" do
    command "chown -R ubuntu:ubuntu #{nrpe_config_dir} && chown -R ubuntu:ubuntu #{nrpe_scripts_dir}"
  end

end