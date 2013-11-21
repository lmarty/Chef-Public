#
# Cookbook Name:: app_database
# Library:: generic
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

require 'chef/provider'
require 'chef/resource'

class Chef
  class Provider
    class AppDatabaseGeneric < Chef::Provider

      attr_accessor :config

      def initialize(new_resource, run_context)
        super

        @config = new_resource.attribute_mash_formatted({
          :date => Time.new.strftime('%Y-%m-%d')
        })

        @uri = URI(@new_resource.uri)
        raise ::Chef::Exceptions::ArgumentError, "Could not parse database URI. (#{@uri})" unless @uri
      end

      def load_current_resource
        @current_resource = ::ResourceMasher::ResourceMash.from_hash({
          :schema_version => schema_version
        })
      end

      def whyrun_supported?
        false
        #TODO Improve whyrun support.
      end

      def action_backup
        ensure_basepath
        do_backup
      end

      def action_configure
        ensure_basepath
        do_configure
      end

      def action_migrate
        ensure_basepath
        verA = @current_resource.schema_version
        verB = @new_resource.schema_version
        if verA && ::Gem::Version.new(verA) >= ::Gem::Version.new(verB)
          ::Chef::Log.info("#{self.to_s} schema already up to date. Nothing to do.")
        else
          do_migrate
          schema_version(verB)
        end
      end

      private

      def ensure_basepath
        new_resource = @new_resource
        if not ::File.exists?(new_resource.basepath)
          directory new_resource.basepath do
            action :create
            owner new_resource.owner
            group new_resource.group
            mode 0750
          end.run_action_now
        end

        @new_resource.basepath
      end

      def schema_version(version=nil)
        schema_ver_file = "#{@new_resource.basepath}/#{@new_resource.type}-schema.version"
        if version
          ::File.open(schema_ver_file, 'w') do |f|
            f.write("#{version}\n")
            f.write("This file is used by the Chef 'app_database' LWRP for automatic migration purposes.\n")
          end
        elsif ::File.exists?(schema_ver_file)
          ::File.open(schema_ver_file, 'r') do |f|
            f.readline()
          end
        else
          return nil
        end
      end

      def do_backup
        raise ::Chef::Exceptions::UnsupportedAction, "#{self.to_s} does not support :backup"
      end

      def do_configure
        raise ::Chef::Exceptions::UnsupportedAction, "#{self.to_s} does not support :configure"
      end

      def do_migrate
        raise ::Chef::Exceptions::UnsupportedAction, "#{self.to_s} does not support :migrate"
      end

    end
  end
end
