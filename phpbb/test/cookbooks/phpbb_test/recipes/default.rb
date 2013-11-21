
# include_recipe "phpbb::auto_install"

chef_gem 'faraday'
chef_gem 'rspec-expectations'
require 'faraday'
require 'rspec-expectations'

# Test recipe

append_if_no_line "adding phpbb1.local entry in /etc/hosts file to test the app response" do
  path "/etc/hosts"
  line "127.0.0.1 phpbb1.local"
end

phpbb_instance "phpbb1" do
  doc_root "/var/www/phpbb1"
  db_name "phpbb1_db"
  db_user "phpbb1_user"
  db_password "phpbb1_passwd"
  domain "phpbb1.local"
end

