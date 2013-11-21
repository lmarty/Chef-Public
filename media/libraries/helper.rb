#
# Cookbook Name:: media
#
# Copyright (C) 2013 Kannan Manickam
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

module Media
  module Helper
    # Obtains the file system type of the given device
    #
    # @param device [String] the device to get the file system for
    #
    # @return [String] the type of file system. returns nil if the file system
    #   type could not be found
    #
    def self.get_file_system_type(device)
      blkid_cmd = Mixlib::ShellOut.new("blkid -o value #{device}")
      Chef::Log.info "Running command '#{blkid_cmd.command}'"
      blkid_cmd.run_command
      Chef::Log.info "Command stdout: #{blkid_cmd.stdout}"
      Chef::Log.info "Command stderr: #{blkid_cmd.stderr}"
      blkid_cmd.error!

      blkid_cmd.stdout.strip.split("\n").last
    end
  end
end

