users = data_bag(:asterisk_users) || []
dialplan_contexts = data_bag(:asterisk_contexts) || []

template "#{node['asterisk']['prefix']['conf']}/asterisk/asterisk.conf" do
  source 'asterisk.conf.erb'
  mode 0644
  notifies :reload, resources('service[asterisk]')
end

%w{sip manager modules extensions}.each do |template_file|
  template "/etc/asterisk/#{template_file}.conf" do
    source "#{template_file}.conf.erb"
    mode 0644
    variables :users => users, :dialplan_contexts => dialplan_contexts
    notifies :reload, resources('service[asterisk]')
  end
end
