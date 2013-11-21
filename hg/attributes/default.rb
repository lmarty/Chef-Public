case node['platform']
when "ubuntu"
  default['hg']['repo'] = nil # Can be "ppa"
end
