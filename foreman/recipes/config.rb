directory node['foreman']['config_path']

template ::File.join(node['foreman']['config_path'], "settings.yaml")
template ::File.join(node['foreman']['config_path'], "database.yml")
