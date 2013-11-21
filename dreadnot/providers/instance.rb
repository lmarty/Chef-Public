# encoding: utf-8

action :create do
  is_recent_ubuntu = platform?('ubuntu') &&
                     node['platform_version'].to_f >= 10.04

  git_clone = git instance_dir(new_resource.name) do
    user node['dreadnot']['user']
    group node['dreadnot']['group']
    repository new_resource.git_repository
    revision new_resource.git_revision
    action :sync
    only_if { new_resource.git_repository }
  end

  smf "dreadnot-#{new_resource.name}" do
    user node['dreadnot']['user']
    group node['dreadnot']['group']
    start_command 'dreadnot ' <<
      "-p #{ensure_http_port(new_resource.name, new_resource.http_port)}"
    stop_command ':kill'
    working_directory instance_dir(new_resource.name)
    notifies :enable, "service[dreadnot-#{new_resource.name}]"
    notifies :start, "service[dreadnot-#{new_resource.name}]"
    only_if { platform?('smartos') }
  end

  template "/etc/init/dreadnot-#{new_resource.name}.conf" do
    source node['dreadnot']['upstart_template_file']
    cookbook node['dreadnot']['upstart_template_cookbook']
    variables(
      port: ensure_http_port(new_resource.name, new_resource.http_port),
      cwd: instance_dir(new_resource.name)
    )
    notifies :enable, "service[dreadnot-#{new_resource.name}]"
    notifies :start, "service[dreadnot-#{new_resource.name}]"
    only_if { is_recent_ubuntu }
  end

  service "dreadnot-#{new_resource.name}" do
    provider is_recent_ubuntu ? Chef::Provider::Service::Upstart : nil
    action :nothing
  end

  new_resource.updated_by_last_action(git_clone.updated_by_last_action?)
end

action :remove do
  dir = directory instance_dir(new_resource.name) do
    action :delete
  end

  new_resource.updated_by_last_action(dir.updated_by_last_action?)
end
