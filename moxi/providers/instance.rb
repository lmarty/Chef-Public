def load_current_resource
  new_resource.v_bucket_map new_resource.v_bucket_map || (0...new_resource.server_list.size).to_a.map { |i| "[#{i}]" }.join(",")
end


action :create do
  execute "rebuild_moxi_config" do
    action :nothing
    command "cat /etc/moxi.d/* > /etc/moxi.conf"
  end

  directory "/etc/moxi.d"

  template "/etc/moxi.d/#{new_resource.name}" do
    source "moxi.conf.erb"
    notifies :run, "execute[rebuild_moxi_config]"
    mode "0644"
    owner "root"
    group "root"
    variables  :port           => new_resource.port,
      :hash_algorithm => new_resource.hash_algorithm,
      :num_replicas   => new_resource.num_replicas,
      :server_list    => new_resource.server_list,
      :v_bucket_map   => new_resource.v_bucket_map

  end

  new_resource.updated_by_last_action(true)
end

action :destroy do
  directory "/etc/moxi.d"

  file "/etc/moxi.d/#{new_resource.name}" do
    action :delete
    notifies :run, "execute[rebuild_moxi_config]"
  end

  new_resource.updated_by_last_action(true)
end
