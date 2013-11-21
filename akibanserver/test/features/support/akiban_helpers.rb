def query(sql)
  cmd_prefix = test_client_host ? "ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@#{test_client_host}" : ''
  result = %x{echo "#{sql}" | #{cmd_prefix} psql -h #{test_server_host} -p #{test_server_port} -t -q -A #{test_schema}}
  assert $?.success?
  result
end
alias :insert :query
alias :update :query
alias :delete :query

def delete_chef(name)
  delete("DELETE FROM tv_chef WHERE name = '#{name}'")
end

def insert_chef(name)
  insert("INSERT INTO tv_chef (name) VALUES('#{name}')")
end

def select_tv_chefs
  @tv_chefs = query('SELECT name FROM tv_chef ORDER BY name').split("\n")
  @tv_chefs
end

def test_client_host
  ENV['TEST_CLIENT_HOST']
end

def test_schema
  'akibanserver_test'
end

def test_server_host
  ENV['TEST_SERVER_HOST'] || 'localhost'
end

def test_server_port
  ENV['TEST_SERVER_PORT'] || '15432'
end

def tv_chefs
  @tv_chefs
end

def update_chef_name(old_name, new_name)
  update("UPDATE tv_chef SET name = '#{new_name}' WHERE name = '#{old_name}'")
end

