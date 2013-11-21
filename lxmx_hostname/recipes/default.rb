ohai 'reload' do
  action :nothing
end

if node['net']
  fqdn         = node['net']['FQDN']
  the_hostname = node['net']['hostname']
  ip           = node['net']['IP']

  if node['hostname'] != the_hostname
    # Update the hostname
    case node['platform']
    when 'ubuntu', 'debian'
      file '/etc/hostname' do
        content "#{the_hostname}\n"
        mode '0644'
      end
    when 'redhat', 'centos'
      ruby_block 'edit /etc/sysconfig/network' do
        block do
          rc = Chef::Util::FileEdit.new('/etc/sysconfig/network')
          rc.search_file_replace_line(/^HOSTNAME/, "HOSTNAME=#{the_hostname}")
          rc.write_file
        end
      end
    when 'gentoo'
      file '/etc/conf.d/hostname' do
        content "HOSTNAME=\"#{the_hostname}\"\n"
      end
    end

    hostsfile_entry '127.0.0.1' do
      hostname the_hostname
      aliases ['localhost', 'localhost.localdomain']
    end

    execute "hostname #{the_hostname}" do
      notifies :reload, 'ohai[reload]'
    end
  end

  if fqdn && node['fqdn'] != fqdn
    # Update the FQDN
    case node['platform']
    when 'ubuntu', 'debian'
      hostsfile_entry '127.0.1.1' do
        hostname fqdn
        aliases [ the_hostname ]
      end
    when 'redhat', 'centos'
      hostsfile_entry ip do
        hostname fqdn
        aliases [ the_hostname ]
      end
    when 'gentoo'
      hostsfile_entry '127.0.0.1' do
        hostname fqdn
        aliases [ the_hostname, 'localhost.localdomain', 'localhost' ]
      end
    end

    execute "true" do
      notifies :reload, 'ohai[reload]'
    end
  end
end
