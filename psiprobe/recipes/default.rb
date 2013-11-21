#
# Cookbook Name:: psiprobe
# Recipe:: default
#
# License :  GNU GPL v2
#
# Copyright 2011, FLEETING CLOUDS
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
# 
#

# Packages needed for the this cookbook
%w{ libxml-xpath-perl }.each do |pkg|
  package pkg do
    action :install
  end
end

def find(file_name, key)
	if not File.exist?(file_name) then return "CAUTION : version file not found." end

	open(file_name) do |sf|
		while line = sf.gets
			break if not line.index(key).nil?
  	end
		if line.nil? then return "CAUTION : no version record found in version file" end
		return line [  key.length + line.index(key)..-1  ]
	end
end

TOMCAT_HOME="#{node[:psiprobe][:tomcat_home]}"
TOMCAT_CONF="#{node[:psiprobe][:tomcat_conf]}"
SUCCESS_FILE="version.properties"

SUCCESS_FILE_PATH=TOMCAT_HOME + "/webapps/probe/WEB-INF/" + SUCCESS_FILE
SEARCH_KEY='probe.version='

$version=find(SUCCESS_FILE_PATH, SEARCH_KEY)

remote_file "psi_probe_pkg" do
	path "#{Chef::Config['file_cache_path']}/probe-#{node[:psiprobe][:version]}.zip"
	source "#{node[:psiprobe][:mirror]}/probe-#{node[:psiprobe][:version]}.zip"
	mode "0644"
	not_if do File.exist?("#{Chef::Config['file_cache_path']}/probe-#{node[:psiprobe][:version]}.zip")
	end
end

bash "unzip-psiprobe" do
	code <<-EOH
	cd #{node[:psiprobe][:tomcat_home]}/webapps
	rm -f probe.war
	rm -f Changelog.txt
	unzip "#{Chef::Config['file_cache_path']}/probe-#{node[:psiprobe][:version]}.zip"
	EOH
	not_if do $version .eql? "#{node[:psiprobe][:version]}"
	end
end

bash "add-manager" do
	code <<-EOH
#	echo "New manager uid : #{node[:psiprobe][:manager_uid]}"
#	echo "New manager password : #{node[:psiprobe][:manager_pwd]}"
#	echo "Will define a manager? #{node[:psiprobe][:define_manager]}"
	if [  ".#{node[:psiprobe][:define_manager]}." == ".true."  ]; then

		declare PATCH=""

		declare ROLE_DEFINED=`cat #{node[:psiprobe][:tomcat_conf]}/tomcat-users.xml | xpath -q -e "//role[@rolename='manager']"`
		declare ROL_DEFD=`echo ${ROLE_DEFINED} | grep -c "manager"`
		echo Found  rolename='manager'  listed ${ROL_DEFD} times in tomcat-users.xml.
		if [  ${ROL_DEFD} -lt 1  ]; then
			PATCH="${PATCH}    <role rolename=\\"manager\\"/>\\n"
			echo Will insert "<role rolename=\\"manager\\"/>\\n"
		fi

		declare USER_DEFINED=`cat #{node[:psiprobe][:tomcat_conf]}/tomcat-users.xml | xpath -q -e "//user[@username='#{node[:psiprobe][:manager_uid]}']/@roles"`
		USR_DEFD=`echo ${USER_DEFINED} | grep -c "manager"`
		echo Found  username='#{node[:psiprobe][:manager_uid]}'   listed ${USR_DEFD} times in tomcat-users.xml.
		if [  ${USR_DEFD} -lt 1  ]; then
			PATCH="${PATCH}    <user username=\\"#{node[:psiprobe][:manager_uid]}\\" password=\\"#{node[:psiprobe][:manager_pwd]}\\" roles=\\"manager\\"/>\\n"
			echo Will insert "<user username=\\"#{node[:psiprobe][:manager_uid]}\\" password=\\"*******\\" roles=\\"manager\\"/>\\n"
		fi
		
		cp #{node[:psiprobe][:tomcat_conf]}/tomcat-users.xml #{node[:psiprobe][:tomcat_conf]}/tomcat-users.xml.original

		cat #{node[:psiprobe][:tomcat_conf]}/tomcat-users.xml.original | sed "s|</tomcat-users>|${PATCH}</tomcat-users>|" > #{node[:psiprobe][:tomcat_conf]}/tomcat-users.xml


	else
		echo "no"
	fi
	EOH
end

ruby_block "how_did_it_go" do
	block do
		if $version .eql? "#{node[:psiprobe][:version]}" 
			puts "* Did nothing. Version " + $version + " seemed to be installed already. * "
		end
		if not File.exist?("#{node[:psiprobe][:tomcat_home]}") 
			puts "* * * Could not install Psi Probe since TomCat is not installed! * * * "
		end
	end
	action :create
end



