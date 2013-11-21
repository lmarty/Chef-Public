################################################################################

action :create do
  # If no key
  execute  "creating servercert private key for #{new_resource.name}" do
    command "openssl genrsa -out /etc/pki/tls/private/#{new_resource.name}.key 2048"
    not_if "/usr/bin/test -f /etc/pki/tls/private/#{new_resource.name}.key"
  end

  # If key but no cert, generate CSR
  execute  "generating certificate request" do
    cmd = "openssl req"
    cmd += " -new"
    cmd += " -nodes"
    cmd += " -subj '/CN=#{new_resource.name}/'"
    cmd += " -key /etc/pki/tls/private/#{new_resource.name}.key"
    cmd += " -out /etc/pki/tls/private/#{new_resource.name}.csr"
    command cmd
    not_if  "/usr/bin/test -f /etc/pki/tls/private/#{new_resource.name}.csr"
    only_if "/usr/bin/test -f /etc/pki/tls/private/#{new_resource.name}.key"
  end

  # put CSR into attribute
  ruby_block "Setting pki csr attribute for #{node[:fqdn]}" do
    block do
      node.set['pki']['csr'][:"#{new_resource.name}"] = IO.read("/etc/pki/tls/private/#{new_resource.name}.csr")
    end
    not_if  "/usr/bin/test -f /etc/pki/tls/certs/#{new_resource.name}.crt"
    only_if "/usr/bin/test -f /etc/pki/tls/private/#{new_resource.name}.key"
    only_if "/usr/bin/test -f /etc/pki/tls/private/#{new_resource.name}.csr"
  end
 
  # rsync cert
  ruby_block  "rsyncing certificate #{new_resource.name}.crt from pki" do
    block do
      system("/usr/bin/rsync #{new_resource.pkiserver}::pki/#{new_resource.name}.crt /etc/pki/tls/certs/") 
    end
    not_if  "/usr/bin/test -f /etc/pki/tls/certs/#{new_resource.name}.crt"
    only_if "/usr/bin/test -f /etc/pki/tls/private/#{new_resource.name}.key"
    only_if "/usr/bin/test -f /etc/pki/tls/private/#{new_resource.name}.csr"
    ignore_failure true
  end

  # retract CSR node attribute to prevent server from acting on it
  ruby_block "Removing pki csr attribute for #{node[:fqdn]}" do
    block do
      node.normal_attrs['pki'].delete('csr')
      new_resource.updated_by_last_action(true)
    end
    only_if "/usr/bin/test -f /etc/pki/tls/certs/#{new_resource.name}.crt"
  end

end
