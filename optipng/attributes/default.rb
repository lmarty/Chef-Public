default['optipng']['install_method'] = "package"

case node['platform']
when 'ubuntu'
  default['optipng']['repository'] = "ppa"
end
