#
# Cookbook Name:: mogilefs
# Attributes:: mogilefs
#
# Author:: Jamie Winsor (<jamie@enmasse.com>)
#
# Copyright 2011, En Masse Entertainment, Inc.
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

default[:mogilefs][:bin_path] = "/usr/local/bin"
default[:mogilefs][:dir]      = "/etc/mogilefs"
default[:mogilefs][:user]     = "mogile"

default[:mogilefs][:mogilefsd][:conf_port]      = 7001
default[:mogilefs][:mogilefsd][:listener_jobs]  = 10
default[:mogilefs][:mogilefsd][:delete_jobs]    = 1
default[:mogilefs][:mogilefsd][:replicate_jobs] = 5
default[:mogilefs][:mogilefsd][:reaper_jobs]    = 1
default[:mogilefs][:mogilefsd][:mog_root]       = "/var/mogdata"

default[:mogilefs][:mogstored][:http_listen] = "0.0.0.0:7500"
default[:mogilefs][:mogstored][:mgmt_listen] = "0.0.0.0:7501"
default[:mogilefs][:mogstored][:doc_root]    = "/var/mogdata"
