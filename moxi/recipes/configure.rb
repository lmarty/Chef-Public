directory "/etc/moxi/"

template "/etc/moxi/moxi.conf" do
  source "moxi.conf.erb"
  mode "0644"
  owner "root"
  group "root"
end
