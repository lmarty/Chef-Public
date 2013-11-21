node.default['asterisk']['prefix']['bin'] = '/usr'

case node['platform']
when 'ubuntu', 'debian'
  apt_repository 'asterisk' do
    uri node['asterisk']['package']['repo']['url']
    distribution node['asterisk']['package']['repo']['distro']
    components node['asterisk']['package']['repo']['branches']
    keyserver node['asterisk']['package']['repo']['keyserver']
    key node['asterisk']['package']['repo']['key']
    only_if node['asterisk']['package']['repo']['enable']
  end

  node['asterisk']['package']['names'].each do |pkg|
    package pkg
  end
end
