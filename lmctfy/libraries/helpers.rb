# encoding: utf-8
# Helpers module
module Helpers
  # Helpers::Lmctfy module
  module Lmctfy
    @sys_proctable_installed = false

    def containers
      containers = []
      llc = shell_out('lmctfy list containers')
      llc.stdout.each_line do |llc_line|
        container_name = llc_line.chomp.split('=')[1].gsub!(/(^"|"$)/, '')
        containers << container_name
      end
      containers
    end

    def container_command_count(container, command)
      count = 0
      container_processes(container).each do |process|
        count += 1 if command == process['command']
      end
      count
    end

    def container_exists?(container)
      containers.each do |c|
        return true if c.include?(container)
      end
      false
    end

    def container_processes(container)
      install_sys_proctable
      processes = []
      llp = shell_out("lmctfy list pids #{container}")
      llp.stdout.each_line do |llp_line|
        pid = llp_line.chomp.split('=')[1].gsub!(/(^"|"$)/, '')
        next unless pid
        command = Sys::ProcTable.ps(pid.to_i).cmdline
        processes << { 'pid' => pid, 'command' => command }
      end
      processes
    end

    def container_command_running?(container, command)
      container_processes(container).each do |process|
        return true if command == process['command']
      end
      false
    end

    def install_sys_proctable
      chef_gem 'sys-proctable' unless @sys_proctable_installed
      require 'sys/proctable'
      @sys_proctable_installed = true
    end
  end
end
