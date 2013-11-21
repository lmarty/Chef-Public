#--
# Author:: Adam Jacob (<adam@opscode.com>)
# Author:: Daniel DeLeo (<dan@opscode.com>)
# Copyright:: Copyright (c) 2008, 2010 Opscode, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

if Chef::VERSION.split(".").first == '11' 

require 'chef/provider/file'
require 'chef/mixin/template'
require 'chef/mixin/checksum'
require 'chef/file_access_control'
require 'chef/file_content_management/content_base'


class Chef
  class Provider

    class LocalTemplate < Chef::Provider::Template
      
      extend Chef::Deprecation::Warnings
      include Chef::Deprecation::Provider::Template
      add_deprecation_warnings_for(Chef::Deprecation::Provider::Template.instance_methods)
      
      def initialize(new_resource, run_context)
        super
        @content_class = Chef::Provider::LocalTemplate::Content
      end

      def load_current_resource
        @current_resource = Chef::Resource::LocalTemplate.new(@new_resource.name)
        super
      end

      def define_resource_requirements
      end

    end
  end
end

class Chef
  class Provider

    class LocalTemplateFinder < Chef::Provider::TemplateFinder

      def find(template_name, options = {})
        raise "finding template"
        template_source_name(template_name, options)
      end

    protected
      def template_source_name(name, options)
        if options[:source]
          options[:source]
        else
          name
        end
      end
    end
  end
end

class Chef
  class Provider
    class LocalTemplate

      class Content < Chef::FileContentManagement::ContentBase

        include Chef::Mixin::Template

        def template_location
          source = @new_resource.source
        end

        private

        def file_for_provider
          context = TemplateContext.new(@new_resource.variables)
          context[:node] = @run_context.node
          context[:template_finder] = template_finder
          context._extend_modules(@new_resource.helper_modules)
          output = context.render_template(template_location)

          tempfile = Tempfile.open("chef-rendered-template")
          tempfile.binmode
          tempfile.write(output)
          tempfile.close
          tempfile
        end
        
        def template_finder
          @template_finder ||= begin
            LocalTemplateFinder.new(run_context, @new_resource.cookbook_name, @run_context.node)
          end
        end

      end
    end
  end
end


require 'chef/resource/file'
require 'chef/provider/template'
require 'chef/mixin/securable'

class Chef
  class Resource
    class LocalTemplate < Chef::Resource::File
      include Chef::Mixin::Securable

      provides :local_template, :on_platforms => :all

      attr_reader :inline_helper_blocks
      attr_reader :inline_helper_modules

      def initialize(name, run_context=nil)
        super
        @resource_name = :template
        @action = "create"
        @source = "#{::File.basename(name)}.erb"
        @cookbook = nil
        @local = false
        @variables = Hash.new
        @provider = Chef::Provider::LocalTemplate
        @inline_helper_blocks = {}
        @inline_helper_modules = []
        @helper_modules = []
      end

      def source(file=nil)
        set_or_return(
          :source,
          file,
          :kind_of => [ String ]
        )
      end

      def variables(args=nil)
        set_or_return(
          :variables,
          args,
          :kind_of => [ Hash ]
        )
      end

      def cookbook(args=nil)
        set_or_return(
          :cookbook,
          args,
          :kind_of => [ String ]
        )
      end

      def local(args=nil)
        set_or_return(
          :local,
          args,
          :kind_of => [ TrueClass, FalseClass ]
        )
      end

      # Declares a helper method to be defined in the template context when
      # rendering.
      #
      # === Example:
      #
      # ==== Basic usage:
      # Given the following helper:
      # helper(:static_value) { "hello from helper" }
      # A template with the following code:
      # <%= static_value %>
      # Will render as;
      # hello from helper
      #
      # ==== Referencing Instance Variables:
      # Any instance variables available to the template can be referenced in
      # the method body. For example, you can simplify accessing app-specific
      # node attributes like this:
      # helper(:app) { @node[:my_app_attributes] }
      # And use it in a template like this:
      # <%= app[:listen_ports] %>
      # This is equivalent to the non-helper template code:
      # <%= @node[:my_app_attributes][:listen_ports] %>
      #
      # ==== Method Arguments:
      # Helper methods can also take arguments. The syntax available for
      # argument specification will be dependent on ruby version. Ruby 1.8 only
      # supports a subset of the argument specification syntax available for
      # method definition, whereas 1.9 supports the full syntax.
      #
      # Continuing the above example of simplifying attribute access, we can
      # define a helper to look up app-specific attributes like this:
      # helper(:app) { |setting| @node[:my_app_attributes][setting] }
      # The template can then look up attributes like this:
      # <%= app(:listen_ports) %>
      def helper(method_name, &block)
        unless block_given?
          raise Exceptions::ValidationFailed,
            "`helper(:method)` requires a block argument (e.g., `helper(:method) { code }`)"
        end

        unless method_name.kind_of?(Symbol)
          raise Exceptions::ValidationFailed,
            "method_name argument to `helper(method_name)` must be a symbol (e.g., `helper(:method) { code }`)"
        end

        @inline_helper_blocks[method_name] = block
      end

      # Declares a module to define helper methods in the template's context
      # when rendering. There are two primary forms.
      #
      # === Inline Module Definition
      # When a block is given, the block is used to define a module which is
      # then mixed in to the template context w/ `extend`.
      #
      # ==== Inline Module Example
      # Given the following code in the template resource:
      # helpers do
      # # Add "syntax sugar" for referencing app-specific attributes
      # def app(attribute)
      # @node[:my_app_attributes][attribute]
      # end
      # end
      # You can use it in the template like so:
      # <%= app(:listen_ports) %>
      # Which is equivalent to:
      # <%= @node[:my_app_attributes][:listen_ports] %>
      #
      # === External Module Form
      # When a module name is given, the template context will be extended with
      # that module. This is the recommended way to customize template contexts
      # when you need to define more than an handful of helper functions (but
      # also try to keep your template helpers from getting out of hand--if you
      # have very complex logic in your template helpers, you should further
      # extract your code into separate libraries).
      #
      # ==== External Module Example
      # To extract the above inline module code to a library, you'd create a
      # library file like this:
      # module MyTemplateHelper
      # # Add "syntax sugar" for referencing app-specific attributes
      # def app(attribute)
      # @node[:my_app_attributes][attribute]
      # end
      # end
      # And in the template resource:
      # helpers(MyTemplateHelper)
      # The template code in the above example will work unmodified.
      def helpers(module_name=nil,&block)
        if block_given? and !module_name.nil?
          raise Exceptions::ValidationFailed,
            "Passing both a module and block to #helpers is not supported. Call #helpers multiple times instead"
        elsif block_given?
          @inline_helper_modules << block
        elsif module_name.kind_of?(::Module)
          @helper_modules << module_name
        elsif module_name.nil?
          raise Exceptions::ValidationFailed,
            "#helpers requires either a module name or inline module code as a block.\n" +
            "e.g.: helpers do; helper_code; end;\n" +
            "OR: helpers(MyHelpersModule)"
        else
          raise Exceptions::ValidationFailed,
            "Argument to #helpers must be a module. You gave #{module_name.inspect} (#{module_name.class})"
        end
      end

      # Compiles all helpers from inline method definitions, inline module
      # definitions, and external modules into an Array of Modules. The context
      # object for the template is extended with these modules to provide
      # per-resource template logic.
      def helper_modules
        compiled_helper_methods + compiled_helper_modules + @helper_modules
      end

      private

      # compiles helper methods into a module that can be included in template context
      def compiled_helper_methods
        if inline_helper_blocks.empty?
          []
        else
          resource_helper_blocks = inline_helper_blocks
          helper_mod = Module.new do
            resource_helper_blocks.each do |method_name, method_body|
              define_method(method_name, &method_body)
            end
          end
          [ helper_mod ]
        end
      end

      def compiled_helper_modules
        @inline_helper_modules.map do |module_body|
          Module.new(&module_body)
        end
      end

    end
  end
end
end
