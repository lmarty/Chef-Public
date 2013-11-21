default['gflags']['install_type'] = nil

# Source attributes
default['gflags']['archive']['install_dir'] = "/usr/local"
default['gflags']['archive']['version'] = "2.0"
default['gflags']['archive']['url'] = "https://gflags.googlecode.com/files/gflags-#{node['gflags']['archive']['version']}.tar.gz"
default['gflags']['archive']['checksum'] = case node['gflags']['archive']['version']
when "2.0"; "ce4a5d3419f27a080bd68966e5cd9507bfa09d14341e07b78a1778a7a172d7d7"
end

# Package attributes
default['gflags']['package']['cpp_packages'] = value_for_platform(
  %w{centos fedora redhat} => {
    "default" => %w{gflags gflags-devel}
  },
  %w{ubuntu} => {
    "default" => %w{libgflags2 libgflags-dev}
  }
)
default['gflags']['package']['python_packages'] = value_for_platform(
  %w{centos fedora redhat} => {
    "default" => %w{gflags-python}
  },
  %w{ubuntu} => {
    "default" => %w{python-gflags}
  }
)
