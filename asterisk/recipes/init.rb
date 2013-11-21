template '/etc/default/asterisk' do
  source 'init/default-asterisk.erb'
  mode 0644
  notifies :restart, resources('service[asterisk]')
end

template '/etc/init.d/asterisk' do
  source 'init/init-asterisk.erb'
  mode 0755
  notifies :restart, resources('service[asterisk]')
end
