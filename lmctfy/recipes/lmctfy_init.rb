# encoding: utf-8
# Temporarily handle init every Chef run...
# TODO: init should be done via init/upstart/systemd

execute 'lmctfy init' do
  command "lmctfy init \"#{node['lmctfy']['init']}\""
  action :run
end
