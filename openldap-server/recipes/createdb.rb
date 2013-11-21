template '/tmp/db.ldif' do
  source node['openldap-server'][:db_ldif]
  owner 'root'
  group 'root'
  mode '0644'
  notifies :run, 'execute[create_db]'
end

execute 'create_db' do
  command 'sudo ldapadd -Y EXTERNAL -H ldapi:/// -f /tmp/db.ldif'
  creates '/etc/ldap/slapd.d/cn=config/olcDatabase={1}hdb.ldif'
  action :nothing
end

