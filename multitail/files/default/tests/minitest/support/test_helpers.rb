require 'minitest/spec'


module Cocoach
	module TestHelpers
		include MiniTest::Chef::Assertions
		include MiniTest::Chef::Context
		include MiniTest::Chef::Resources


		def link_points_to( target, origin )
			assert system "sudo readlink #{target} | grep ^#{origin}$"
		end


		def file_is_readable_by( path, user )
			assert system "sudo -u #{user} cat #{path}"
		end


		def file_is_writable_by( path, user )
			assert system "sudo -u #{user} touch #{path}"
		end


		def service_is_listening( port, service )
			assert system "sudo netstat -lp --numeric-ports | grep \":#{port}.*LISTEN.*#{service}\""
		end


		def bin_on_path( bin )
			assert system "which #{bin} | grep \"#{bin}\""
		end


		def has_mysql_user( user )
			query         = 'SELECT User FROM user;'
			pass          = node['mysql']['server_root_password']
			mysql_command = "mysql --password=\"#{pass}\" -B -D \"mysql\" -e \"#{query}\""
			assert system "#{mysql_command} | grep #{user}"
		end
	end
end