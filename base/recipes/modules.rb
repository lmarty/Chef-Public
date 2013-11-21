
template "/etc/modules" do
  source "modules.erb"
  variables :modules => node[:modules]
end
