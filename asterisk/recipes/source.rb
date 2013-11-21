node.default['asterisk']['prefix']['bin'] = "/opt/asterisk-#{node['asterisk']['source']['version']}"

case node['platform']
when "ubuntu", "debian"
  node['asterisk']['source']['packages'].each do |pkg|
    package pkg do
      options "--force-yes"
    end
  end
end

source_tarball = "asterisk-#{node['asterisk']['source']['version']}.tar.gz"
source_url =  node['asterisk']['source']['url'] ||
    "http://downloads.asterisk.org/pub/telephony/asterisk/releases/#{source_tarball}"
source_path = "#{Chef::Config['file_cache_path'] || '/tmp'}/#{source_tarball}"

remote_file source_tarball do
  source source_url
  path source_path
  checksum node['asterisk']['source']['checksum']
  backup false
  notifies :create, 'ruby_block[validate asterisk tarball]', :immediately
end

# The checksum on remote_file is used only to determine if a file needs downloading
# Here we verify the checksum for security/integrity purposes
ruby_block 'validate asterisk tarball' do
  action :nothing
  block do
    require 'digest'
    expected = node['asterisk']['source']['checksum']
    actual = Digest::SHA256.file(source_path).hexdigest
    if expected and actual != expected
      raise "Checksum mismatch on #{source_path}.  Expected sha256 of #{expected} but found #{actual} instead"
    end
  end
end

bash "install_asterisk" do
  user "root"
  cwd File.dirname(source_path)
  code <<-EOH
    tar zxf #{source_path}
    cd asterisk-#{node['asterisk']['source']['version']}
    ./configure --prefix=#{node['asterisk']['prefix']['bin']} --sysconfdir=#{node['asterisk']['prefix']['conf']} --localstatedir=#{node['asterisk']['prefix']['state']}
    make
    make install
    make config
    #{'make samples' if node['asterisk']['source']['install_samples']}
  EOH
  notifies :reload, resources('service[asterisk]')
end
