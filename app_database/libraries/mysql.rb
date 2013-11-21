#
# Cookbook Name:: app_database
# Library:: mysql
#
# Author:: BinaryBabel OSS (<projects@binarybabel.org>)
# Homepage:: http://www.binarybabel.org
# License:: Apache License, Version 2.0
#
# For bugs, docs, updates:
#
#     http://code.binbab.org
#
# Copyright 2013 sha1(OWNER) = df334a7237f10846a0ca302bd323e35ee1463931
#  
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#  
#     http://www.apache.org/licenses/LICENSE-2.0
#  
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

%w{
  generic
}.each do |req|
  require File.expand_path("#{req}.rb", File.dirname(__FILE__))
end

class Chef
  class Provider
    class AppDatabaseMysql < AppDatabaseGeneric

      def initialize(new_resource, run_context)
        super

        @config.type = @uri.scheme
        @config.host = @uri.host
        @config.port = @uri.port
        @config.database = @uri.path.to_s.sub(%r{^/},'')
        @config.validate({
          :type => { :equal_to => 'mysql' },
          :host => { :required => true, :regex => /^[a-zA-Z0-9\.-]+$/ },
          :port => { :kind_of => Integer, :default => 3306 },
          :database => { :required => true, :regex => /^[a-zA-Z0-9\.-]+$/ },
          :username => { :required => true },
          :password => { :required => true }
        })
      end

      def do_backup
        backup_file = config.backup_file
        backup_file_tgz = "#{backup_file}.tgz"

        unix_bin "mysqldump" do
          action :require
        end

        bash "#{config.app_name}_mysql_backup" do
          user config.owner
          group config.group
          cwd config.basepath
          code <<-EOH
mysqldump --defaults-extra-file=mysql.conf #{config.database} > "#{backup_file}" \
  && tar -czf "#{backup_file_tgz}" "#{backup_file}" && rm "#{backup_file}"
          EOH
          not_if { ::File.exists?("#{config.basepath}/#{backup_file_tgz}") }
        end
      end  # / :backup

      def do_configure
        template "#{config.basepath}/mysql.conf" do
          cookbook "app_database"
          source "mysql.conf.erb"
          owner config.owner
          group config.group
          mode 0600
          variables config.symbolize_keys
        end
      end  # / :configure

      def do_migrate
        migration_file = "#{config.basepath}/latest-migration.sql"

        unix_bin "mysql" do
          action :require
        end

        tpl_vars = {
          :current_resource => @current_resource,
          :current_version => ::Gem::Version.new(@current_resource.schema_version),
          :new_resource => @new_resource,
          :new_version => ::Gem::Version.new(@new_resource.schema_version)
        }
        template migration_file do
          source config.schema_template
          owner config.owner
          group config.group
          mode 0600
          variables tpl_vars
        end

        bash "#{config.app_name}_mysql_migrate" do
          user config.owner
          group config.group
          cwd config.basepath
          code <<-EOH
cat "#{migration_file}" | mysql --defaults-extra-file=mysql.conf #{config.database} && rm "#{migration_file}"
          EOH
        end
      end  # / :migrate

    end
  end
end
