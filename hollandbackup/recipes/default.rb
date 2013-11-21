#
# Cookbook Name:: hollandbackup
# Recipe:: default
#
# Copyright 2012-2013, David Joos
#

case node[:platform]
	when "debian", "ubuntu"
		####
		#DEB
		####

		#trust the hollandbackup GPG key
		distro = node[:hollandbackup][:distro]

		if distro
			gpg_key_url = "http://download.opensuse.org/repositories/home:/holland-backup/#{distro}/Release.key"

			gpg_key_already_installed = "apt-key list | grep #{distro}"

			if gpg_key_url
				execute "wget -O - #{gpg_key_url} | apt-key add -" do
					notifies :run, "execute[hollandbackup-apt-get-update]", :immediately
					not_if gpg_key_already_installed
				end
			end
		end

		#configure the hollandbackup apt repository
		local_file = "/etc/apt/sources.list.d/holland.list"

		file "#{local_file}" do
			owner "root"
			group "root"
			mode 0640
			content "deb http://download.opensuse.org/repositories/home:/holland-backup/#{distro}/ ./"
			notifies :run, "execute[hollandbackup-apt-get-update]", :immediately
			action :create_if_missing
		end

		#update the local package list
		execute "hollandbackup-apt-get-update" do
			command "apt-get update"
			action :nothing
		end
end