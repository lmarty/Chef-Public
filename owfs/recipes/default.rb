package 'owfs-common'

template "/etc/owfs.conf" do
  owner "root"
  group "root"
  mode "0644"

  source "owfs.conf.erb"
  variables node[:owfs]
end
