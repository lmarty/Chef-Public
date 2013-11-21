actions :create,:git,:install,:start,:stop

attribute :initial_data_template, :kind_of => String, :default => "initial_data.json.erb"
attribute :python_interpreter, :kind_of => String, :default => "python2.7"
attribute :init_style, :kind_of => String, :default => "upstart"
attribute :cookbook, :kind_of => String, :default => "graphite"
attribute :user, :kind_of => String, :default => "graphite"
attribute :group, :kind_of => String, :default => "graphite"
attribute :workers, :kind_of => String, :default => "1"
attribute :timeout, :kind_of => Fixnum, :default => 300
attribute :backlog, :kind_of => Fixnum, :default => 655355
attribute :limit_request_line, :kind_of => Fixnum, :default => 0
attribute :listen_port, :kind_of => Fixnum, :default => 8080
attribute :listen_address, :kind_of => String, :default => "0.0.0.0"
attribute :cpu_affinity
attribute :local_settings_template, :kind_of => String, :default => "local_settings.py.erb"
attribute :web_template, :kind_of => String, :default => "graphite-web.init.erb"
attribute :graphite_home, :kind_of => String, :default => "/opt/graphite"
attribute :graphite_core_packages, :kind_of => Hash, :default => { "gunicorn" => "0.16.1", "Django" => "1.3", "django-tagging" => "0.3.1", "simplejson" => "2.1.6", "Twisted" => "11.1.0", "python-memcached" => "1.47", "txAMQP" => "0.4", "pytz" => "2012b", "django-tagging" => "0.3.1" }
attribute :graphite_packages, :kind_of => Hash, :default => { "graphite-web" => "0.9.10" }
attribute :graphite_stable_packages, :kind_of => Hash, :default => { "graphite-web" => "0.9.x", "whisper" => "0.9.x" }
attribute :graphite_stable_base_git_uri, :kind_of => String, :default => "https://github.com/graphite-project/"
attribute :debug, :kind_of => String, :default => "False"
attribute :time_zone, :kind_of => String, :default => "UTC"
attribute :log_rendering_performance, :kind_of => String, :default => "False"
attribute :log_cache_performance, :kind_of => String, :default => "False"
attribute :documentation_url, :kind_of => String, :default => String.new
attribute :smtp_server, :kind_of => String, :default => String.new
# FIXME: This should actually do something
attribute :use_ldap_auth, :kind_of => String, :default => String.new
attribute :database_engine, :kind_of => String, :default => String.new
# "postgresql_psycopg2"
attribute :database, :kind_of => Hash, :default => { :name => 'graphite', :user => 'graphite', :password => String.new, :host => String.new, :port => 5432 }
attribute :cluster_servers, :kind_of => String, :default => String.new
attribute :memcache_hosts, :kind_of => String, :default => String.new
attribute :rendering_hosts, :kind_of => String, :default => String.new
attribute :remote_rendering, :kind_of => String, :default => "False"
attribute :standard_dirs, :kind_of => String, :default => String.new
attribute :carbonlink_hosts, :kind_of => Array, :default => Array.new

def initialize(*args)
  super
  @action = :nothing
  @run_context.include_recipe ["build-essential","python","python::pip","python::virtualenv","git","runit::default"]
end
