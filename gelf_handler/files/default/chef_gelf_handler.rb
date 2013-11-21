require 'rubygems'
require 'gelf'
require 'chef'
require 'chef/handler'
require 'chef/log'

class Chef
  module GELF
    class Handler < Chef::Handler
      attr_reader :notifier
      attr_reader :options

      def options=(value = {})
        @options = {:port => 12201, :facility => 'chef_client', :blacklist => {}, :host => nil, :report_host => nil }.merge(value)
      end

      def initialize(options = {})
        self.options = options

        Chef::Log.debug "Initialised GELF handler for gelf://#{self.options[:host]}:#{self.options[:port]}/#{self.options[:facility]}"
        @notifier = ::GELF::Notifier.new(self.options[:host], self.options[:port], 'WAN', :facility => self.options[:facility])
      end

      def report
        Chef::Log.debug "Reporting #{run_status.inspect}"
        begin
          if run_status.failed?
            Chef::Log.debug "Notifying GELF server of failure."
            @notifier.notify!(:short_message => "Chef run failed on #{node.name}. Updated #{changes[:count]} resources.",
                              :full_message => run_status.formatted_exception + "\n" + Array(backtrace).join("\n") + changes[:message],
                              :level => ::GELF::Levels::FATAL,
                              :host => options[:report_host])
          else
            Chef::Log.debug "Notifying GELF server of success."
            @notifier.notify!(:short_message => "Chef run completed on #{node.name} in #{elapsed_time}. Updated #{changes[:count]} resources.",
                              :full_message => changes[:message],
                              :level => ::GELF::Levels::INFO,
                              :host => options[:report_host])
          end
        rescue Exception => e
          # Capture any exceptions that happen as a result of transmission. i.e. Host address resolution errors.
          Chef::Log.error("Error reporting to gelf server: #{e}")
        end
      end

      protected

      def changes
        @changes unless @changes.nil?

        lines = sanitised_changes.collect do |resource|
          "recipe[#{resource.cookbook_name}::#{resource.recipe_name}] ran '#{resource.action}' on #{resource.resource_name} '#{resource.name}'"
        end

        count = lines.size

        message = if count > 0
          "Updated #{count} resources:\n\n#{lines.join("\n")}"
        else
          "No changes made."
        end

        @changes = { :lines => lines, :count => count, :message => message }
      end

      def sanitised_changes
        run_status.updated_resources.reject do |updated|

          recipe_key = "#{updated.cookbook_name}::#{updated.recipe_name}"
          resource_key = "#{updated.resource_name}[#{updated.name}]"

          resource = (@options[:blacklist][recipe_key] || {})[resource_key] || []
          actions = updated.action.is_a?(Array) ? updated.action : [updated.action]
          reject = actions.all?{|action|resource.include?(action.to_s)}
          Chef::Log.debug "#{reject ? 'Blacklisting' : 'Accepting'} Change: recipe[#{recipe_key}] #{resource_key} action '#{updated.action}'"
          reject
        end
      end
    end
  end
end
