# for database config, these are required:
default[:openfire][:database][:type] = nil
default[:openfire][:database][:password] = nil

# these are optional:
default[:openfire][:database][:name] = 'openfire'
default[:openfire][:database][:user] = 'openfire'
default[:openfire][:database][:host] = '127.0.0.1'
default[:openfire][:database][:port] = nil # (derived from :type)

db = openfire[:database]

# missing critical db info, skip db configs
if db[:type].nil? or db[:password].nil?
	default[:openfire][:database][:active] = false
	return
end

# have all db info, populate db configs
default[:openfire][:database][:active] = true

# if it's a local database, set up the server
# also expect to find db privileged users information
case db[:host]
when '127.0.0.1', 'localhost'
	default[:openfire][:database][:local] = true
else
	default[:openfire][:database][:local] = false
end

db_port = db[:port]
if db_port.nil?
	case db[:type]
	when 'postgresql'
		db_port = 5432
	when 'mysql'
		db_port = 3306
	else
		raise "don't know how to set a port for db type #{db[:type]}"
	end
end
default[:openfire][:database][:port] = db_port

default[:openfire][:config][:database][:driver] = "org.#{db[:type]}.Driver"
default[:openfire][:config][:database][:server_url] = "jdbc:#{db[:type]}://#{db[:host]}:#{db_port}/#{db[:name]}"
