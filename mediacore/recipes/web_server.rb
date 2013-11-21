case node[:mediacore][:web_server][:type]
when "nginx"
  node.set[:nginx][:default_site_enabled] = false
  include_recipe "nginx"

  template "#{node[:nginx][:dir]}/sites-available/mediacore" do
    action :create
    source "nginx.conf.erb"
    notifies :restart, "service[nginx]", :delayed
  end

  nginx_site "mediacore" do
    action :enable
  end
when "apache2"
# TODO: Implement support for apache2
end
