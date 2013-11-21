DESCRIPTION:
============
Proof of concept PKI implementation, powered by inter-node convergence and stateful resource providers.

REQUIREMENTS
============
RHEL6/Centos6 or higher
hostname resolution taken care of earlier in the runlist (DNS, or a
generated hostsfile)

ATTRIBUTES
============
node['pki']['openssldir']

USAGE
============

Clients check to see if they have an SSL keypair  for their FQDN.
If not, pki_servercert is called, which generates a private key and a CSR.
The node then posts it's CSR as a node attribute

When the server side runs, it searches for a list of clients with the pki csr attribute
set. When it finds a CSR, it signs it and places the resulting public key in a directory exposed by rsync. 
Since these are public keys, there are no security concerns here.

When a client is satisfied about its certificate, it will remove the attribute.

* https://github.com/someara/pki-cookbook
