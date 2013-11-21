default['httpie']['version'] = "0.6.0" 
default['httpie']['arch'] = kernel['machine'] =~ /x86_64/ ? "amd64" : "386" 
