require 'chef/handler'

class Chef
  class Handler
    class AttrbaggerHandler < ::Chef::Handler
      def initialize(options = {})
        @run_context = options[:run_context]
        @autoload = !!options[:autoload]
        @autoloaded = false
      end

      def report
        return unless @autoload
        unless @autoloaded
          if run_status && run_status.run_context
            Attrbagger.autoload!(run_status.run_context)
            @autoloaded = true
          else
            Attrbagger.autoload!(@run_context)
            @autoloaded = true
          end
        end
      end
    end
  end
end
