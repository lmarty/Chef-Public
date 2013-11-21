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

# Should a local user account be created for Zenoss servers to 
# authenticate with
default['zenoss']['client']['create_local_user'] = true

# The name of the local user to be created
default['zenoss']['client']['local_user_name'] = 'zenoss'

# The comment to assign to the user account
default['zenoss']['client']['local_user_comment'] = 'Zenoss monitoring account'

# The shell for the user. This will only be set on os's that support setting
# a user shell
default['zenoss']['client']['local_user_shell'] = '/bin/bash'

# The home directory of the user. This will only be set on os's that support
# setting a users home directory
default['zenoss']['client']['local_user_homedir'] = '/home/zenoss'

# Which collector should this node be assigned to
default['zenoss']['client']['collector'] = "localhost"

# The name of the Zenoss server. This should be used if you 
# are running under Chef-solo, or for some other reason, are not able
# to locate your zenoss server via search. If this value is anything other
# than nil, this value will trump other detection methods
default['zenoss']['client']['server'] = nil

# The HTTP port on which your Zenoss Server listening. This should
# be used if youare running under Chef-solo, or for some other reason
# are able to locate this via search. If this value is anything other
# than nil, this value will trump other detection methods
default['zenoss']['client']['server_port'] = nil

# What version of the zenoss_client rubygem do we want to use
default['zenoss']['client']['gem_version'] = "0.5.4"


