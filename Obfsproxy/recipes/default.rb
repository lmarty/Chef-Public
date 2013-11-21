#
# Cookbook Name:: obfsproxy server
# Recipe:: default
#
#

     %w{autoconf autotools-dev gcc git pkg-config make libtool libevent-2.0-5 libevent-dev libevent-openssl-2.0-5 libssl-dev}.each do |pkg|
      package pkg do
        action :install
      end
    end

	clone = "obfsproxy.git"
		<span style="text-decoration: line-through;">execute "wget" do
			clone_url = "https://git.torproject.org/obfsproxy.git"
			cwd "/tmp"
			command "wget #{clone_url}"
			creates "/tmp/#{clone}"
			command "cd obfsproxy"
			command "./autogen.sh && ./configure && make"
			command "make install"
		action :run
	end</span> 
