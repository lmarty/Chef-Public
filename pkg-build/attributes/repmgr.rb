default[:pkg_build][:repmgr][:base_uri] = 'http://www.repmgr.org/download'
default[:pkg_build][:repmgr][:version] = '2.0beta1'
default[:pkg_build][:repmgr][:build_dir] = '/var/cache/repmgr'
default[:pkg_build][:repmgr][:dependencies] = %w(postgresql-9.1)
default[:pkg_build][:repmgr][:packages][:pg_dev] = 'postgresql-server-dev-9.1'
default[:pkg_build][:repmgr][:packages][:dependencies] = %w(libxslt1-dev libpam0g-dev libedit-dev)
default[:pkg_build][:repmgr][:pg_home] = '/var/lib/postgresql'
