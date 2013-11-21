include_recipe 'owfs'

package 'owserver'

service 'owserver' do
  supports :status => true, :restart => true, :reload => true
  action :start
  subscribes :restart, resources("template[/etc/owfs.conf]"), :delayed
end
