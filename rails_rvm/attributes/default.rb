# I would recommend overriding the user type attributes with values from a databag

default[:rails_rvm][:user] = "rails"
# Default password is "rails"
# You can get more info about creating a password hash at:
# http://wiki.opscode.com/display/chef/Resources#Resources-User
default[:rails_rvm][:password] = "$1$ltU0eGhl$uOXpm7kfOx/ii9hSu5Dlk."
default[:rails_rvm][:uid] = 1010
default[:rails_rvm][:gid] = 1010

# ironruby, jruby, rbx, ree, 1.8.7, 1.9.2, 1.9.3
default[:rails_rvm][:rvm_version] = "1.9.3"
default[:rails_rvm][:rails_version] = "3.2.5"

