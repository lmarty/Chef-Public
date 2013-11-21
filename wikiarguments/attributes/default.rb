default['wikiarguments']['shortener']=false
default['wikiarguments']['webserver']="lighttpd" #apache2

default['wikiarguments']['email']="wikiarguments@#{node['domain']}"
default['wikiarguments']['email_name']="Wikiarguments"

default['wikiarguments']['database']['database']="wikiarguments"
default['wikiarguments']['database']['username']="wikiarguments"
default['wikiarguments']['database']['host']="localhost"
default['wikiarguments']['database']['password']=nil
