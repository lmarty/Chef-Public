use_inline_resources

action :create do
  ca_name="#{new_resource.name}".upcase

  # create CA index
  execute "creating PKI index file" do
    command "/bin/touch /etc/pki/#{ca_name}/index.txt"
    not_if  "/usr/bin/test -f /etc/pki/#{ca_name}/index.txt"
  end
  
  # create CA serial
  execute "starting PKI serial file" do
    command "/bin/echo '01' > /etc/pki/#{ca_name}/serial"
    not_if  "/usr/bin/test -f /etc/pki/#{ca_name}/serial" 
  end

  # create CA crlnumber
  execute "starting crlnumber" do
    command "echo '01' > /etc/pki/#{ca_name}/certs/ca.srl"
    not_if  "/usr/bin/test -f /etc/pki/#{ca_name}/certs/ca.srl"
  end

  # generate self signed key
  execute "generating CA private key" do    
    cmd = "openssl req"
    cmd += " -x509"
    cmd += " -nodes" 
    cmd += " -days 3650"
    cmd += " -subj '/CN=#{node[:fqdn]}/'"
    cmd += " -newkey rsa:2048"
    cmd += " -keyout /etc/pki/#{ca_name}/private/ca.key"
    cmd += " -out /etc/pki/#{ca_name}/certs/ca.crt"
    cmd += " 2>&1>/dev/null"
    command cmd
    not_if  "/usr/bin/test -f /etc/pki/#{ca_name}/private/ca.key"
    not_if  "/usr/bin/test -f /etc/pki/#{ca_name}/certs/ca.crt"
  end

  # retract CSR
  ruby_block "retract CSR from node object" do
    block do
      node.set['pki']['cacert'] = IO.read("/etc/pki/#{ca_name}/certs/ca.crt")
    end
    only_if "/usr/bin/test -f /etc/pki/#{ca_name}/certs/ca.crt"
  end
      
end

