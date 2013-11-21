default['metarepo']['directory'] = "/opt/metarepo/embedded"
default['metarepo']['git_url'] = "git://github.com/fujin/metarepo.git"
default['metarepo']['git_action'] = :sync
default['metarepo']['home'] = "/opt/metarepo"
default['metarepo']['user'] = "metarepo"
default['metarepo']['uid'] = 5000
default['metarepo']['group'] = "metarepo"
default['metarepo']['gid'] = 500
default['metarepo']['config_file'] = "/etc/metarepo.rb"
default['metarepo']['pool_path'] = "/opt/metarepo/pools"
default['metarepo']['repo_path'] = "/opt/metarepo/repos"
default['metarepo']['upstream_path'] = "/opt/metarepo/upstreams"
default['metarepo']['uri'] = "http://localhost:6667"
default['metarepo']['gpg_key'] = "metarepo@example.com"

default['metarepo']['database']['name'] = "metarepo"
default['metarepo']['database']['user'] = "metarepo"
default['metarepo']['database']['password'] = nil
default['metarepo']['database']['hostname'] = "127.0.0.1"
default['metarepo']['database']['host'] = "%"
default['metarepo']['database']['privileges'] = %w{all}.map(&:to_sym)

