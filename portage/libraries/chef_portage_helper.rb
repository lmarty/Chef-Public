class Chef
  module Portage
    module Helper

      def modify_file(file, action)
        entry = new_resource.entry
        ruby_block "edit #{file}: #{action.to_s} #{entry}" do
          block do
            yield entry
            edit.write_file
          end
        end
      end

      def add
        modify_file @config, :add do |entry|
          edit.insert_line_if_no_match(entry, entry)
        end
      end

      def remove
        modify_file @config, :remove do |entry|
          edit.search_file_delete_line(entry)
        end
      end

      def replace_or_insert(value)
        modify_file @config, :replace_line do |entry|
          edit.search_file_replace_line(entry, value)
          edit.insert_line_if_no_match(entry, value)
        end
      end

      def ensure_file_exists(config)
        if !File.exists?(config) || (File.new(config).readlines.length == 0)
          File.open(config, 'w') do |f|
            # Chef::Util::FileEdit expects a non-blank file
            f.write("# Created by Chef\n")
            f.close
          end
        end
      end

      def edit
        @edit ||= begin
          ensure_file_exists(@config)
          Chef::Util::FileEdit.new(@config)
        end
      end
    end
  end
end
