
case node['platform']
when 'ubuntu'
  default['pgbadger']['install_method'] = "ppa"
else
  default['pgbadger']['install_method'] = "sources"
  default['pgbadger']['source'] = "git" # or tarball
end
