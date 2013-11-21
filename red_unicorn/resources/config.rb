def initialize(*args)
  super
  @action = :create
end

actions :create, :delete

attribute :bundled, :kind_of => [TrueClass, FalseClass], :required => false, :default => true
attribute :current_path, :kind_of => String, :required => false, :default => '/var/www/current'
attribute :shared_path, :kind_of => String, :required => false, :default => '/var/www/shared'
attribute :bundled_path, :kind_of => String, :required => false, :default => '/var/www/current/vendor'
attribute :bundled_bin, :kind_of => String, :required => false, :default => '/var/www/current/bin'
attribute :unicorn_listen, :kind_of => String, :required => false, :default => '/var/run/unicorn/unicorn.socket'
attribute :unicorn_listen_options, :kind_of => Hash, :required => false, :default => {:backlog => 64}
attribute :unicorn_timeout, :kind_of => Fixnum, :required => false, :default => 30
attribute :unicorn_pid, :kind_of => String, :required => false, :default => '/var/run/unicorn/unicorn.pid'
attribute :cow_friendly, :kind_of => [TrueClass, FalseClass], :required => false, :default => false
attribute :user, :kind_of => String, :required => false, :default => 'www-data'
attribute :group, :kind_of => String, :required => false, :default => 'www-data'
attribute :worker_processes, :kind_of => Integer, :required => false, :default => 1
attribute :preload_app, :kind_of => [TrueClass, FalseClass], :required => false, :default => true
attribute :unicorn_directory, :kind_of => String, :required => false, :default => '/etc/unicorn'
attribute :max_memory_usage_mb, :kind_of => Integer, :required => false, :default => 100
attribute :max_cpu_usage_percent, :kind_of => Integer, :required => false, :default => 20
attribute :unicorn_exec, :kind_of => String, :required => false
attribute :red_unicorn_exec, :kind_of => String, :required => false
attribute :environment, :kind_of => String, :required => false, :default => 'production'
attribute :environment_variables, :kind_of => Hash, :required => false, :default => {}
attribute :start_grace_time, :kind_of => Fixnum, :required => false, :default => 30
attribute :stop_grace_time, :kind_of => Fixnum, :required => false, :default => 30
attribute :restart_grace_time, :kind_of => Fixnum, :required => false, :default => 60
attribute :unicorn_preload_app, :kind_of => [TrueClass, FalseClass], :required => false, :default => true
