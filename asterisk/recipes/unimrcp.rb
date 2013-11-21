case node['platform']
when "ubuntu", "debian"
  node['asterisk']['unimrcp']['packages'].each do |pkg|
    package pkg do
      options "--force-yes"
    end
  end
end

unimrcp_name = "uni-ast-package-#{node['asterisk']['unimrcp']['version']}"
unimrcp_src_dir = "#{Chef::Config['file_cache_path'] || '/tmp'}/#{unimrcp_name}"

target_dir = node['asterisk']['unimrcp']['install_dir']

apr_src_dir = "#{unimrcp_src_dir}/unimrcp/libs/apr"

remote_file "#{work_dir}/#{unimrcp_name}.tar.gz" do
  source "http://unimrcp.googlecode.com/files/#{unimrcp_name}.tar.gz"
end

bash "prepare_dir" do
  user "root"
  cwd work_dir
  code 'tar -zxf #{unimrcp_name}.tar.gz'
end

bash "install_apr" do
  user "root"
  cwd apr_src_dir
  code <<-EOH
    ./configure --prefix=#{target_dir}
    make
    make install
  EOH
end

bash "install_apr_util" do
  user "root"
  cwd "#{unimrcp_src_dir}/unimrcp/libs/apr-util"
  code <<-EOH
    ./configure --prefix=#{target_dir} --with-apr=#{apr_src_dir}
    make
    make install
  EOH
end

bash "install_sofia" do
  user "root"
  cwd "#{unimrcp_src_dir}/unimrcp/libs/sofia-sip"
  code <<-EOH
    ./configure --with-glib=no
    make
    make install
  EOH
end

bash "install_unimrcp" do
  user "root"
  cwd "#{unimrcp_src_dir}/unimrcp"
  code <<-EOH
    ./configure --prefix=#{target_dir} --with-apr=#{target_dir} --with-apr-util=#{target_dir}
    make
    make install
  EOH
end

directory "/var/lib/asterisk/documentation/thirdparty" do
  mode 0644
  action :create
  recursive true
end

bash "install_asterisk_modules" do
  user "root"
  cwd "#{unimrcp_src_dir}/modules"
  code <<-EOH
    ./configure
    make
    make install
  EOH
end

bash "ldconfig" do
  user "root"
  cwd work_dir
  code 'ldconfig'
end

template "/etc/asterisk/mrcp.conf" do
  source "mrcp.conf.erb"
  mode 0644
  notifies :reload, resources('service[asterisk]')
end
