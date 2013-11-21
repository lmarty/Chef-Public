
def load_current_resource
  if(new_resource.unicorn_exec.to_s.empty?)
    new_resource.unicorn_exec ::File.join(new_resource.bundled_bin, 'unicorn_rails')
  end
end

action :create do

  bluepill_service new_resource.name do
    action :nothing
  end

  directory ::File.dirname(new_resource.unicorn_pid) do
    action :create
    owner new_resource.user
    group new_resource.group
  end

  directory new_resource.unicorn_directory do
    action :create
    owner new_resource.user
    group new_resource.group
  end

  template ::File.join(new_resource.unicorn_directory, "#{new_resource.name}.rb") do
    source 'unicorn.app.erb'
    cookbook 'red_unicorn'
    mode 0644
    mapped_vars = %w(
      bundled current_path shared_path bundled_path unicorn_listen unicorn_listen_options
      unicorn_timeout unicorn_pid cow_friendly user group worker_processes bundled_bin
      unicorn_preload_app environment_variables
    ).map do |var|
      [var,new_resource.send(var)]
    end
    variables(
      Hash[*mapped_vars.flatten]
    )
    notifies :restart, resources(:bluepill_service => new_resource.name), :delayed
  end

  template ::File.join(node[:bluepill][:conf_dir], "#{new_resource.name}.pill") do
    source 'bluepill.erb'
    cookbook 'red_unicorn'
    variables(
      :red_unicorn_exec => "#{node[:red_unicorn][:exec]} -p #{new_resource.unicorn_pid} -x #{new_resource.unicorn_exec} -c #{::File.join(new_resource.unicorn_directory, "#{new_resource.name}.rb")} -e #{new_resource.environment} -t #{new_resource.restart_grace_time}",
      :app_name => new_resource.name,
      :process_name => "unicorn_#{new_resource.name}",
      :pid_file => new_resource.unicorn_pid,
      :current_dir => new_resource.current_path,
      :user => new_resource.user,
      :group => new_resource.group,
      :start_grace_time => new_resource.start_grace_time,
      :stop_grace_time => new_resource.stop_grace_time,
      :restart_grace_time => new_resource.restart_grace_time,
      :mem_usage_mb => new_resource.max_memory_usage_mb,
      :cpu_usage_percent => new_resource.max_cpu_usage_percent
    )
    mode 0644
    notifies :restart, resources(:bluepill_service => new_resource.name), :delayed
  end

  bluepill_service new_resource.name do
    action [:enable, :load, :start]
  end

  new_resource.updated_by_last_action(true)

end

action :delete do
  #TODO: If unmonitor makes it upstream to "unload" item, this needs
  # to be updated so we don't needlessly restart everything
  bluepill_service new_resource.name do
    action [:disable, :restart]
  end
  file ::File.join(new_resource.unicorn_directory, "#{new_resource.name}.app") do
    action :delete
  end
  file ::File.join(node[:bluepill][:conf_dir], "#{new_resource.name}.pill") do
    action :delete
  end
  new_resource.updated_by_last_action(true)
end
