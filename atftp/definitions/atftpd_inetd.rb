

define :atftpd_inetd, :use_inetd => false do

  if (params[:use_inetd] || node[:tftpd][:use_inetd])
    execute "update-inet.d --enable tftp" do
      command "/usr/sbin/update-inetd --enable tftp"
      notifies :restart, resources(:service => "atftpd")
    end
  else
    execute "update-inet.d --disable tftp" do
      command "/usr/sbin/update-inetd --disable tftp"
      notifies :restart, resources(:service => "atftpd")
    end
  end
end