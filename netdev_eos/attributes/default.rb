#
# Chef Cookbook   : netdev_eos
# File            : attributes/default.rb
#    
# Copyright 2013 Arista Networks
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
default[:netdev_config][:databag_name] = "netdev_config"

default[:netdev_config][:providers][:netdev_interface] = "netdev_eos_interface"
default[:netdev_config][:providers][:netdev_l2_interface] = "netdev_eos_l2_interface"
default[:netdev_config][:providers][:netdev_vlan] = "netdev_eos_vlan"
default[:netdev_config][:providers][:netdev_lag] = "netdev_eos_lag"
