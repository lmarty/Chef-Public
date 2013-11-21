
package 'sendmail' do
	action :remove
end


service 'sendmail' do
	action [ :stop, :disable ]
end