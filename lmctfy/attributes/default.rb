# encoding: utf-8

default['lmctfy']['cgroups']['packages'] = value_for_platform(
  %w{centos fedora redhat} => {
    'default' => %w{libcgroup}
  },
  %w{ubuntu} => {
    'default' => %w{cgroup-bin libcgroup1}
  }
)

default['lmctfy']['init'] = ''

default['lmctfy']['install_type'] = 'source'

case node['lmctfy']['install_type']
when 'source'
  default['lmctfy']['install_dir'] = '/usr/local'
else
  default['lmctfy']['install_dir'] = '/usr'
end

# Source attributes
default['lmctfy']['source']['ref'] = 'master'
default['lmctfy']['source']['url'] = 'https://github.com/google/lmctfy.git'
