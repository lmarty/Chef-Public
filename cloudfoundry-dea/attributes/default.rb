#
# Cookbook Name:: cloudfoundry-dea
# Attributes:: default
#
# Copyright 2012-2013, ZephirWorks
# Copyright 2012, Trotter Cashion
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

# Where to install the CloudFoundry code.
default['cloudfoundry_dea']['vcap']['install_path'] = "/srv/vcap-dea"

# Repository to use when fetching the CloudFoundry code.
default['cloudfoundry_dea']['vcap']['repo']         = "https://github.com/cloudfoundry/dea.git"

# Git reference to use when fetching the CloudFoundry code. Can be
# either a specific sha or a reference such as `HEAD` or `master`.
default['cloudfoundry_dea']['vcap']['reference']    = "0ad8c731844335440078c254a1db767dc0d357ae"

# TODO (trotter): Find out what is stored here.
default['cloudfoundry_dea']['base_dir']    = "/var/vcap/data/dea"

# TODO (trotter): Find out what this does.
default['cloudfoundry_dea']['filter_port'] = 12345

# Interval (in seconds) between heartbeats sent to the Health Manager.
default['cloudfoundry_dea']['heartbeat']   = 10

# Interval (in seconds) for sending advertisments of available resources.
default['cloudfoundry_dea']['advertise']   = 5

# Log level for the DEA.
default['cloudfoundry_dea']['log_level']   = "info"

# The maximum amount of memory this DEA is allowed to allocate across
# all its applications.
default['cloudfoundry_dea']['max_memory']  = 4096

# TODO (trotter): Find out what this does.
default['cloudfoundry_dea']['secure_env']  = false

# Allow the DEA to manage more than one application.
default['cloudfoundry_dea']['multi_tenant'] = true

default['cloudfoundry_dea']['index'] = nil

default['cloudfoundry_dea']['detect_port_timeout'] = 120

# Internal only, nothing to see here.
default['cloudfoundry_dea']['runtimes'] = {}
