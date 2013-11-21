include_recipe "mediacore::packages"
include_recipe "mediacore::web_server"

[ node[:mediacore][:dir],
  node[:mediacore][:log_location]
].each do |dir|
  directory dir do
    action :create
    owner node[:mediacore][:user]
    group node[:mediacore][:group]
    mode "0775"
  end
end

git node[:mediacore][:dir] do
  repository node[:mediacore][:git_repo]
  reference "v#{node[:mediacore][:version]}"
  user node[:mediacore][:user]
  group node[:mediacore][:group]
  notifies :run,"execute[mediacore_setup]",:delayed
end

directory node[:mediacore][:venv] do
  action :create
  owner node[:mediacore][:user]
  group node[:mediacore][:group]
  mode "0775"
end

python_virtualenv node[:mediacore][:venv] do
  owner node[:mediacore][:user]
  group node[:mediacore][:group]
  options "--distribute --no-site-packages"
  action :create
end

template "#{node[:mediacore][:dir]}/deployment.ini" do
  action :create
  mode "0755"
  owner node[:mediacore][:user]
  group node[:mediacore][:group]
  source "deployment.ini.erb"
end

python_pip "uwsgi" do
  action :install
end

case node[:mediacore][:db_type]
when "postgresql"
  include_recipe "postgresql::client"
  python_pip "psycopg2" do
    action :install
    virtualenv node[:mediacore][:venv]
  end
end
  
execute "mediacore_setup" do
  user node[:mediacore][:user]
  cwd node[:mediacore][:dir]
  command "#{node[:mediacore][:venv]}/bin/python setup.py develop"
  action :nothing
  notifies :run, "execute[application_migration]", :delayed
end

execute "application_migration" do
  user node[:mediacore][:user]
  cwd node[:mediacore][:dir]
  command "#{node[:mediacore][:venv]}/bin/paster setup-app deployment.ini"
  action :nothing
end

include_recipe "supervisor"

supervisor_service "mediacore" do
  command "uwsgi --ini-paste #{node[:mediacore][:dir]}/deployment.ini --vacuum --die-on-term"
  user node[:mediacore][:user]
  numprocs 1
  autostart true
  autorestart true
  stopsignal "TERM"
  directory node[:mediacore][:dir]
end
