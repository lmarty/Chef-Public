#
# Author:: Julian Dunn (<jdunn@opscode.com>)
# Cookbook Name:: teamforge
# Provider:: frsfile
#
# Copyright:: 2013, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'fileutils'
require 'tempfile'
require 'tmpdir'
require 'chef/digester'
require 'chef/mixin/shell_out'

include Chef::Mixin::ShellOut

# Support whyrun
def whyrun_supported?
  true
end

def load_current_resource
  @current_resource = Chef::Resource::TeamforgeFrsfile.new(@new_resource.name)
  @current_resource.filename(@new_resource.filename)

  if ::File.exists?(@current_resource.filename)
    @current_resource.exists = true
    @current_resource.checksum = Chef::Digester.checksum_for_file(@current_resource.filename)
  else
    @current_resource.exists = false
  end
end

action :create do

  f = Tempfile.new(['get-payload', '.ctf'])
  begin
    f.puts ("connect #{new_resource.ctf}")
    f.puts ("go #{new_resource.frsid}")
    f.puts ("download")
  ensure
    f.close
  end

  d = Dir.mktmpdir

  shell_out!(payload_retrieval_command(node['teamforge']['cli']['prog'], d, f.path))
  f.unlink

  downloaded_filename = ::File.join(d, ::File.basename(new_resource.filename))

  if !::File.exists?(downloaded_filename)
    Chef::Log.fatal("Failed to retrieve file from FRS")
  else
    new_resource.checksum = Chef::Digester.checksum_for_file(downloaded_filename)

    if !@current_resource.exists || (current_resource.checksum != new_resource.checksum)
      converge_by("old checksum doesn't match new one") do
        FileUtils.mv(downloaded_filename, new_resource.filename)
      end
    else
      ::File.delete(downloaded_filename)
    end
  end

  Dir.rmdir(d)

end

private

def payload_retrieval_command (ctfprog, dir, script)
  %Q{cd #{dir} && #{ctfprog} --script #{script}}
end
