directory "/var/chef/handlers" do
  recursive true
  action :nothing
end.run_action(:create)

cookbook_file "/var/chef/handlers/reportchef.rb" do
  action :nothing
end.run_action(:create)

chef_handler "Chef::Handler::ReportChef" do
  source "/var/chef/handlers/reportchef"
  arguments :api_key => node['reportchef']['api_key']
  action :nothing
end.run_action(:enable)
