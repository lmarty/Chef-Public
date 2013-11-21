require "mixlib/log/formatter"

module Mixlib
  module Log
    class Formatter < Logger::Formatter
      # Prints a log message as '[time] severity: message' if Chef::Log::Formatter.show_time == true.
      # Otherwise, doesn't print the time.
      def call(severity, time, progname, msg)
        reset = "\033[0m"
        color = case severity
        when "FATAL"
          "\033[1;41m" # Bright Red
        when "ERROR"
          "\033[31m" # Red
        when "WARN"
          "\033[33m" # Yellow
        when "INFO"
          "\033[35m" # Magenta
        when "DEBUG"
          "\033[33m" # Yellow
        else
          reset # Normal
        end
        sprintf("[%s] #{color}%s#{reset}: %s\n", time.iso8601(), severity, msg2str(msg))
      end
    end
  end
end
