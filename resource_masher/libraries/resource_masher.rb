#
# Cookbook Name:: resource_masher
# Library:: resource_masher
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

require 'chef/mash'
require 'chef/mixin/params_validate'

module ResourceMasher

  class ResourceMash < ::Mash
    include ::Chef::Mixin::ParamsValidate

    # Chef's Mash doesn't natively allow for object (dot) notation attribute access.
    def method_missing(method, *args, &block)
      if (match = method.to_s.match(/(.*)=$/)) && args.size == 1
        # Assigning.
        self[match[1]] = args.first
      elsif (match = method.to_s.match(/(.*)\?$/)) && args.size == 0
        # Querying.
        key?(match[1])
      elsif key?(method)
        # Fetching.
        self[method]
      else
        super
      end
    end

    # Helper function to quickly validate changes to resource mash.
    def validate(map)
      data = super(symbolize_keys, map)
      data.each do |k,v|
        self[k.to_sym] = v
      end
    end

    def self.from_hash(hash)
      mash = ResourceMash.new(hash)
      mash.default = hash.default
      mash
    end
  end  # /ResourceMash

  module ChefResource
    def attribute_mash(source=nil)
      source ||= self
      hash = Hash.new

      pattern = Regexp.new('^_set_or_return_(.+)$')

      source.public_methods(false).each do |method|
        pattern.match(method) do |m|
          attribute = m[1].to_sym
          hash[attribute] = send(attribute)
        end
      end

      ResourceMash.from_hash(hash)
    end

    def attribute_mash_formatted(default_data=nil, source=nil)
      source ||= self

      if default_data && (default_data.is_a?(Hash) || default_data.is_a?(Mash))
        data = default_data
      else
        data = Hash.new
      end
      data = Mash.from_hash(data) unless data.is_a?(Mash)
      data.merge!(attribute_mash(source))
      data = data.symbolize_keys  # becomes Hash again

      max_iterations = 3

      data.each do |k,v|
        next unless v.is_a? String

        for i in 1..max_iterations
          v2 = v % data
          if (v2 == v)
            break
          else
            data[k] = v = v2
          end
        end  # /for
      end  # /each_value

      ResourceMash.from_hash(data)
    end
  end  # /Resource

end  # /ResourceMasher

# Inject attribute_mash methods into Chef::Resource class.
unless ::Chef::Resource.public_method_defined?(:attribute_mash)
  ::Chef::Resource.send(:include, ResourceMasher::ChefResource)
end
