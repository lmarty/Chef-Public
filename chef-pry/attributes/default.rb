case node['platform_family']
when 'rhel', 'fedora'
  default['chef-pry']['dependencies'] = %w[libxml2-devel libxslt-devel]
when 'ubuntu', 'debian'
  default['chef-pry']['dependencies'] = %w[libxml2-dev libxslt-dev]
end
