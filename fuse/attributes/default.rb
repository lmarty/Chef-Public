#
## Author:: Rilindo.Foster (rilindo.foster@monzell.com)
## Cookbook Name:: fuse
## Attribute:: default
##
## Licensed under the Apache License, Version 2.0 (the "License");
## you may not use this file except in compliance with the License.
## You may obtain a copy of the License at
##
##     http://www.apache.org/licenses/LICENSE-2.0
##
## Unless required by applicable law or agreed to in writing, software
## distributed under the License is distributed on an "AS IS" BASIS,
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
## See the License for the specific language governing permissions and
## limitations under the License.
##

default['fuse']['package_name'] = 'fuse'

# fuse-smb not available in EPEL or repoforge.

if platform?('fedora') || platform?('centos') || platform?('rhel')
  default['fuse']['clients']['sshfs'] = 'fuse-sshfs'
  default['fuse']['clients']['zip'] = 'fuse-zip'
  default['fuse']['clients']['iso'] = 'fuseiso'
  default['fuse']['clients']['encfs'] = 'fuse-encfs'
  default['fuse']['clients']['smb'] = 'fuse-smb'
else
  default['fuse']['clients']['sshfs'] = 'sshfs'
  default['fuse']['clients']['zip'] = 'fuse-zip'
  default['fuse']['clients']['iso'] = 'fuseiso'
  default['fuse']['clients']['encfs'] = 'encfs'
  default['fuse']['clients']['smb'] = 'fusesmb'
end

