# encoding: utf-8
# Workaround broken Ubuntu 12.10+ and RHEL support in control_groups cookbook
if node['platform'] == 'ubuntu' && node['platform_version'] == '12.04'
  include_recipe 'control_groups'
else
  include_recipe 'apt' if node['platform'] == 'ubuntu'

  node['lmctfy']['cgroups']['packages'].each do |p|
    package p
  end

  if node['platform_family'] == 'rhel' && node['platform_version'] == '6'
    service 'cgconfig' do
      supports status: true, restart: true, reload: true
      action [:enable, :start]
    end
    service 'cgred' do
      supports status: true, restart: true, reload: true
      action [:enable, :start]
    end
  end
end
