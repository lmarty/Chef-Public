default['multitail']['check_mail'] = false

default['multitail']['config_path'] = case node['platform_family']
	when 'mac_os_x' then '/opt/local/etc'
	else '/etc'
end