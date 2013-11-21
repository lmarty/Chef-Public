####################################################################
# COOKBOOK NAME: openindiana
# RECIPE: pkg
# DESCRIPTION: pkg LWRP for managing OI packages
#
####################################################################
# (C)2011 DigiTar, All Rights Reserved
# Distributed under the BSD License
# 
# Redistribution and use in source and binary forms, with or without modification, 
#    are permitted provided that the following conditions are met:
#
#        * Redistributions of source code must retain the above copyright notice, 
#          this list of conditions and the following disclaimer.
#        * Redistributions in binary form must reproduce the above copyright notice, 
#          this list of conditions and the following disclaimer in the documentation 
#          and/or other materials provided with the distribution.
#        * Neither the name of DigiTar nor the names of its contributors may be
#          used to endorse or promote products derived from this software without 
#          specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY 
# EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES 
# OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT 
# SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, 
# INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED 
# TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR 
# BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN 
# ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH 
# DAMAGE.
#
####################################################################

require 'open3'
require 'chef/provider/package'
require 'chef/mixin/command'
require 'chef/resource/package'

class Chef
  class Provider
    class Package
      class Ips < Chef::Provider::Package
        
        attr_accessor :virtual

        def load_current_resource
          @current_resource = Chef::Resource::Ips.new(@new_resource.name)
          @current_resource.package_name(@new_resource.name)
          check_package_state(@new_resource.package_name)
          @current_resource
        end

        def check_package_state(package)
          Chef::Log.debug("Checking package status for #{package}")
          installed = false
          depends = false
          
          Open3.popen3("pkg info -r #{package}") do |stdin, stdout, stderr|
            stdout.each do |line|
              case line
              when /^\s+State: Installed/
                installed = true
              when /^\s+Version: (.*)/
                if installed
                  if not @candidate_version
                    @candidate_version = $1
                    @current_resource.version($1)
                  end
                else
                  @candidate_version = $1
                  @current_resource.version(nil)
                end
              end
            end
          end

          if @candidate_version.nil?
            raise Chef::Exceptions::Package, "pkg does not have a version of package #{@new_resource.package_name}"
          end

          return installed
        end

        def install_package(name, version)
          package_name = "#{name}@#{version}"
          run_command_with_systems_locale(
            :command => "pkg #{expand_options(@new_resource.options)} install -q --accept #{package_name}"
          )
        end

        def upgrade_package(name, version)
          install_package(name, version)
        end

        def remove_package(name, version)
          package_name = "#{name}@#{version}"
          run_command_with_systems_locale(
            :command => "pkg #{expand_options(@new_resource.options)} uninstall -q #{package_name}"
          )
        end
      end
    end
  end
end