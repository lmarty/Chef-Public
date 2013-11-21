if File.exists?("#{Chef::Config[:file_cache_path]}/selenium-server-standalone-2.33.0.jar")
	remote_file "#{Chef::Config[:file_cache_path]}/selenium-server-standalone-2.33.0.jar" do
	  source "https://selenium.googlecode.com/files/selenium-server-standalone-2.33.0.jar"
	  mode 0644
	end
end

# if hub:
#	start jar with "-role hub"