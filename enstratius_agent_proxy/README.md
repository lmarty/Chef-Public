# Enstratius Agent Proxy

## Description
This cookbook will install the [Enstratius Agent Proxy](http://docs.enstratius.com/agent/proxy/proxy.html).

## Requirements
- `runit`
- `java`
- `apt`
- `sudo`
- `yum`

## Attributes

- `node['enstratius_agent_proxy']['user']` 			  User to run as
- `node['enstratius_agent_proxy']['group']` 			  Group to run as
- `node['enstratius_agent_proxy']['home_dir']`  		  User home directory
- `node['enstratius_agent_proxy']['installdir']` 		  Directory to install the proxy
- `node['enstratius_agent_proxy']['ssl_cert']` 			  The `cookbook_file` to use for the SSL cert
- `node['enstratius_agent_proxy']['ssl_key']` 			  The `cookbook_file` to use for the SSL key
- `node['enstratius_agent_proxy']['ssl_cookbook']` 		  The cookbook providing the cert and key
- `node['enstratius_agent_proxy']['config_cookbook']`   	  The cookbook providing the agent config
- `node['enstratius_agent_proxy']['url']` 			  The URL to download the agent
- `node['enstratius_agent_proxy']['filename']` 			  The name of the agent tar file
- `node['enstratius_agent_proxy']['checksum']` 			  The checksum of the tar file
- `node['enstratius_agent_proxy']['port']` 			  The port on which the agent will listen
- `node['enstratius_agent_proxy']['upstream_port']` 		  The upstream provisioning server port
- `node['enstratius_agent_proxy']['disable_upstream_validation']` Is the upstream certificate real?
- `node['enstratius_agent_proxy']['id']` 			  The unique ID of this proxy installation
- `node['enstratius_agent_proxy']['upstream_host']` 		  The hostname or ip of the upstream provisioning server
- `node['enstratius_agent_proxy']['service_type']` 		  The service manager for running the agent proxy
- `node['enstratius_agent_proxy']['service_cookbook']` 		  The cookbook that provides the service recipe

## Usage
You will probably want to create a wrapper cookbook for installing this. This is because we ship with a "canned" set of certificates. If you are comfortable with the shipped SSL certs, then this will install out of the box to talk to the Enstratius SaaS.

If you would like to wrap this and change the SSL cert to your own:

```
knife cookbook create my-agent-proxy
echo "depends 'enstratius-agent-proxy`" >> cookbooks/my-agent-proxy/metadata.rb
```

You should then copy your own certs into `cookbooks/my-agent-proxy/file/default/`. Set the appropriate values in a role or in the wrapper cookbook itself:

- `node['enstratius_agent_proxy']['ssl_cert'] = 'mycert.crt'`
- `node['enstratius_agent_proxy']['ssl_key'] = 'mycert.key'`
- `node['enstratius_agent_proxy']['ssl_cookbook'] = 'my-agent-proxy'`

If you are talking to a private Enstratius installation, you'll also want to set the following:
- `node['enstratius_agent_proxy']['upstream_host'] = 'host1.domain.com'`

If you do not have a valid SSL cert in front of your provisioning system:
- `node['enstratius_agent_proxy']['disable_upstream_validation'] = true`

