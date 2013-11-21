include_recipe "elefant::web"

if node['elefant']['version'] == 'latest'
	local_file = "#{Chef::Config[:file_cache_path]}/elefant-latest.tar.gz"
	unless File.exists?(local_file)
		remote_file "#{Chef::Config[:file_cache_path]}/elefant-latest.tar.gz" do
			source node['elefant']['latest_url']
			mode "0644"
		end
	end
else
	remote_file "#{Chef::Config[:file_cache_path]}/elefant-#{node['elefant']['version']}.tar.gz" do
		source "#{node['elefant']['archive_url']}/elefant_#{node['elefant']['version']}.tar.gz"
		mode "0644"
	end
end

execute "untar-elefant" do
	cwd node['elefant']['document_root']
	command "tar --strip-components 1 -zxf #{Chef::Config[:file_cache_path]}/elefant-#{node['elefant']['version']}.tar.gz"
	creates "#{node['elefant']['document_root']}/elefant"
	notifies :run, "execute[elefant-permissions]", :delayed
end

execute "elefant-permissions" do
	cwd node['elefant']['document_root']
	command "chmod 777 apps && chmod -R 777 cache conf css files lang layouts"
end
