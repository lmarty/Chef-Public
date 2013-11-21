#
# Cookbook Name:: cloudfoundry-health_manager
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
default['cloudfoundry_health_manager']['install_path'] = "/srv/cloudfoundry/health_manager"

# Repository to use when fetching the CloudFoundry code.
default['cloudfoundry_health_manager']['repo']         = "https://github.com/cloudfoundry/health_manager.git"

# Git reference to use when fetching the CloudFoundry code. Can be
# either a specific sha or a reference such as `HEAD` or `master`.
default['cloudfoundry_health_manager']['reference']    = "211be4258511a6cad53c194fae71d86061b00fa9"

# The Health Manager's log level.
default['cloudfoundry_health_manager']['log_level'] = "info"

default['cloudfoundry_health_manager']['intervals']['expected_state_update']  = 60
default['cloudfoundry_health_manager']['intervals']['droplet_lost']           = 30
default['cloudfoundry_health_manager']['intervals']['droplets_analysis']      = 20
default['cloudfoundry_health_manager']['intervals']['flapping_death']         = 1
default['cloudfoundry_health_manager']['intervals']['flapping_timeout']       = 500
default['cloudfoundry_health_manager']['intervals']['restart_timeout']        = 20
default['cloudfoundry_health_manager']['intervals']['min_restart_delay']      = 60
default['cloudfoundry_health_manager']['intervals']['max_restart_delay']      = 480
default['cloudfoundry_health_manager']['intervals']['giveup_crash_number']    = 4
default['cloudfoundry_health_manager']['intervals']['stable_state']           = 60
