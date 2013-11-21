# 
# Cookbook Name:: powerdns
# Attribute File:: server
# Copyright 2009, Adapp, Inc.
pdns_password = ""
chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
20.times { |i| pdns_password << chars[rand(chars.size-1)] }

powerdns Mash.new unless attribute?("powerdns")
powerdns[:server] = Mash.new unless powerdns.has_key?(:server)
unless powerdns[:server].has_key?(:allow_axfr_ips)
  powerdns[:server][:allow_axfr_ips] = "127.0.0.1"
end

unless powerdns[:server].has_key?(:allow_recursion)
  powerdns[:server][:allow_recursion] = "127.0.0.1"
end
powerdns[:server][:default_soa_name] = fqdn unless powerdns[:server].has_key?(:default_soa_name)
powerdns[:server][:default_ttl] = 3600 unless powerdns[:server].has_key?(:default_ttl)
powerdns[:server][:distributor_threads] = 5 unless powerdns[:server].has_key?(:distributor_threads)
powerdns[:server][:username] = "powerdns" unless powerdns[:server].has_key?(:username)
powerdns[:server][:password] = pdns_password unless powerdns[:server].has_key?(:password)
powerdns[:server][:address] = "127.0.0.1" unless powerdns[:server].has_key?(:address)
powerdns[:server][:database] = "powerdns" unless powerdns[:server].has_key?(:database)
