
package 'sendmail' do
  action :purge
end


service 'sendmail' do
  action [ :stop, :disable ]
end