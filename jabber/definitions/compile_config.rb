define :jabber_compile_config do
	directory "/etc/ejabberd" do
		owner 'root'
		group 'jabber'
		mode '0750'
		recursive true
	end

	template "/etc/ejabberd/ejabberd.cfg" do
		source "ejabberd.cfg.erb"
		owner 'root'
		group 'jabber'
		mode '0640'
	end

	template "/etc/ejabberd/ejabberdctl.cfg" do
		source "ejabberdctl.cfg.erb"
		owner 'root'
		group 'jabber'
		mode '0640'
	end

	template "/etc/ejabberd/inetrc" do
		source "inetrc.erb"
		owner 'root'
		group 'root'
		mode '0644'
	end
end
