default[:pkg_build][:ruby][:uri_base] = 'http://ftp.ruby-lang.org/pub/ruby/'
default[:pkg_build][:ruby][:versions] = []
default[:pkg_build][:ruby][:version] = '1.9.3'
default[:pkg_build][:ruby][:patchlevel] = 'p392'
default[:pkg_build][:ruby][:install_prefix] = '/usr/local'
default[:pkg_build][:ruby][:suffix_version] = false
default[:pkg_build][:ruby][:package_dependencies] = %w(
  openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev 
  libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev 
  autoconf libc6-dev ncurses-dev automake libtool bison subversion pkg-config
)
