action :create do

  t = template "/etc/incron.d/#{new_resource.name}" do
    cookbook new_resource.cookbook
    source "incron.d.erb"
    mode "0644"
    variables({
        :name => new_resource.name,
        :path => new_resource.path,
        :mask => new_resource.mask,
        :command => new_resource.command
      })
    action :create
    notifies :reload, "service[incrond]"
  end
  new_resource.updated_by_last_action(t.updated_by_last_action?) 

end

action :delete do

  file "/etc/incron.d/#{new_resource.name}" do
    action :delete
    notifies :reload, "service[incrond]"
  end

end