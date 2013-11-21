#
# Cookbook Name:: linux-dev-env
# Recipe:: eclipse 
#
# Copyright 2012, Gerald L. Hevener Jr., M.S.
#

# Download the Eclipse IDE Classic
case node['target_cpu']

  when "i386"

    execute "download-eclipse-ide-x86_64_classic" do

      command "cd #{node['linux-dev-env']['eclipse_ide_install_dir']};
               wget  http://mirrors.med.harvard.edu/eclipse/eclipse/downloads/drops4/R-4.2.1-201209141800/eclipse-SDK-#{node['linux-dev-env']['eclipse_ide_version']}-linux-gtk.tar.gz;
               tar zxvhf #{node['linux-dev-env']['eclipse_ide_install_dir']}/eclipse-SDK-#{node['linux-dev-env']['eclipse_ide_version']}-linux-gtk.tar.gz;
               chown -R #{node['linux-dev-env']['android_user']}:#{node['linux-dev-env']['android_group']} #{node['linux-dev-env']['eclipse_ide_install_dir']}/eclipse"
      action :run
      not_if "test -d #{node['linux-dev-env']['eclipse_ide_install_dir']}/eclipse"

  end       

  when "x86_64"  

    execute "download-eclipse-ide-x86_64_classic" do

      command "cd #{node['linux-dev-env']['eclipse_ide_install_dir']};
	       wget http://mirrors.xmission.com/eclipse/eclipse/downloads/drops4/R-4.2.1-201209141800/eclipse-SDK-#{node['linux-dev-env']['eclipse_ide_version']}-linux-gtk-x86_64.tar.gz;
	       tar zxvhf #{node['linux-dev-env']['eclipse_ide_install_dir']}/eclipse-SDK-#{node['linux-dev-env']['eclipse_ide_version']}-linux-gtk-x86_64.tar.gz;
               chown -R #{node['linux-dev-env']['android_user']}:#{node['linux-dev-env']['android_group']} #{node['linux-dev-env']['eclipse_ide_install_dir']}/eclipse;"
      action :run
      not_if "test -d #{node['linux-dev-env']['eclipse_ide_install_dir']}/eclipse"

  end

end
