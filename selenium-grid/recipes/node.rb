if File.exists?("#{Chef::Config[:file_cache_path]}/selenium-server-standalone-2.33.0.jar")
	remote_file "#{Chef::Config[:file_cache_path]}/selenium-server-standalone-2.33.0.jar" do
	  source "https://selenium.googlecode.com/files/selenium-server-standalone-2.33.0.jar"
	  mode 0644
	end
end

# if node:
#	start jar with "-role node  -hub '<accessible IP of hub>'"
#	ensure that firefox is installed
#	ensure that chrome is installed
#	if node OS is Windows:
#		ensure IE 10 installed
