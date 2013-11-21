include_recipe "bind"

node.default!['bind']['zones']['attributes'] = [ node['foreman']['domain'] ]
