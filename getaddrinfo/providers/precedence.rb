action :create do
  node.override[:getaddrinfo][:precedences][new_resource.name] = {
    :mask => new_resource.mask,
    :value => new_resource.value
  }

  t = template "/etc/gai.conf" do
    cookbook "getaddrinfo"
    owner "root"
    group "root"
    mode 0644
  end

  new_resource.updated_by_last_action(true) if t.updated_by_last_action?
end
