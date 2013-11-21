node.set['postgresql']['version'] = "9.1"
# Allow Postgres Password-less Authentication
node.set['postgresql']['pg_hba'] = [
  {
    :comment => "# created by chef \'jenkins_build\' for IPv4",
    :type => 'host',
    :db => 'all',
    :user => 'all',
    :addr => '127.0.0.1/32',
    :method => 'trust'
  },
  {
    :comment => "# created by chef \'jenkins_build\' for IPv6",
    :type => 'host',
    :db => 'all',
    :user => 'all',
    :addr => '::1/128',
    :method => 'trust'
  },
]

node.override['ruby_build']['install_pkgs_cruby'] = [
  "gcc-c++",
  "patch",
  "readline",
  "readline",
  "devel",
  "zlib",
  "zlib",
  "devel",
  "libffi",
  "devel",
  "openssl",
  "devel",
  "make",
  "bzip2",
  "autoconf",
  "automake",
  "libtool",
  "bison",
  "libxml2",
  "libxml2",
  "devel",
  "libxslt",
  "libxslt-devel",
  "git",
  "subversion",
  "autoconf"
]

node.default[:jenkins][:server][:plugins] = [
  'git-client',
  'git-server',
  'git',
  'github',
  'ruby-runtime',
  'rbenv',
  'campfire',
  'github-api',
  'ghprb',
]

# Gem Requirements
node.default['jenkins_build']['packages'] = %w{ libxml2-dev libxslt-dev }

# Jenkins Postgres Password
node.default['jenkins_build']['jenkins_user_postgresql_password'] = 'superduperpassword'
