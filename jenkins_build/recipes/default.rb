include_recipe "apt"

log node['platform']
log node['platform_version']
log node['kernel']['machine']

include_recipe "postgresql::server"
include_recipe "postgresql::ruby"
include_recipe "jenkins::server"
include_recipe "nodejs::install_from_source"
include_recipe "phantomjs"
include_recipe "git"

# Add some required packages for this specific configuration
Array(node['jenkins_build']['packages']).each do |selections|
  package selections do
    action  :install
  end
end
# Let us create the Jenkins User in postgres
postgresql_connection_info = {:host => "127.0.0.1",
  :port => node['postgresql']['config']['port'],
  :username => 'postgres',
  :password => node['postgresql']['password']['postgres']}

postgresql_database_user 'jenkins' do
  connection postgresql_connection_info
  password node['jenkins_build']['jenkins_user_postgresql_password']
  action  :create
end
