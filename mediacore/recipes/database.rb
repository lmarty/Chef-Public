include_recipe "database"

case node[:mediacore][:db_type]
when "postgresql"
  include_recipe "postgresql::server"
  include_recipe "postgresql::ruby"

  connection_info = { :host => "localhost",
                      :port => node[:postgresql][:config][:port],
                      :username => "postgres",
                      :password => node[:postgresql][:password][:postgres]
                    } 
  
  postgresql_database node[:mediacore][:database] do
    template 'template0'
    encoding 'UTF8'
    collation 'en_US.utf8'
    connection connection_info 
  end

  postgresql_database_user node[:mediacore][:db_user] do
    connection connection_info
    database_name node[:mediacore][:database]
    password node[:mediacore][:db_pass]
    privileges [:all]
    action [:create, :grant]
  end
when "mysql"
  #TODO: implement
end
