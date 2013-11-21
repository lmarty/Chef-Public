default['enstratius_agent_proxy']['user'] = "esproxy"
default['enstratius_agent_proxy']['group'] = "esproxy"
default['enstratius_agent_proxy']['home_dir'] = '/var/lib/enstratius'
default['enstratius_agent_proxy']['installdir'] = '/opt/enstratius_agent_proxy'
default['enstratius_agent_proxy']['ssl_cert'] = 'proxy.pem'
default['enstratius_agent_proxy']['ssl_key'] = 'proxy.key'
default['enstratius_agent_proxy']['ssl_cookbook'] = 'enstratius_agent_proxy'
default['enstratius_agent_proxy']['config_cookbook'] = 'enstratius_agent_proxy'
# You many need to change this if you know what you are doing
default['enstratius_agent_proxy']['url'] = "http://es-download.s3.amazonaws.com"
default['enstratius_agent_proxy']['filename'] = "es-agentproxy.tar.gz"
default['enstratius_agent_proxy']['checksum'] = "f0e0d4659db3a990c7290096154c1c647224938e4a0836e2b12c42946d5b4e77"
default['enstratius_agent_proxy']['port'] = "2002"
default['enstratius_agent_proxy']['upstream_port'] = "3302"
# If you are talking to a private upstream host without a valid SSL cert, set this to true
default['enstratius_agent_proxy']['disable_upstream_validation'] = "false"
# Probably you'll want to override these ones in your role or run_list
default['enstratius_agent_proxy']['id'] = node['fqdn']
default['enstratius_agent_proxy']['upstream_host'] = "provisioning.enstratus.com"
default['enstratius_agent_proxy']['service_type'] = 'runit'
default['enstratius_agent_proxy']['service_cookbook'] = 'enstratius_agent_proxy'
