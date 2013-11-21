#
# Author:: Adam Edwards (<adamedx>)
# Copyright:: Copyright (c) Adam Edwards
# License:: Apache License, Version 2.0
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
require 'ruby-wmi'

class ComputerInformation
  def get_computer_name
    get_native_computer_information().Name
  end
  
  def get_computer_dns_domain
    get_native_computer_information().Domain
  end

  def set_computer_name(new_name, username, password)
    result = get_native_computer_information().Rename(new_name, password, username)

    raise "Failed to set computername with error #{result}" if result != 0
  end

  def set_computer_dns_domain(domain_name, username, password, organizational_unit)
    result = get_native_computer_information().JoinDomainOrWorkgroup(
      domain_name,
      password,
      username,
      organizational_unit,
      0x20 | 0x4 | 0x2 | 0x1)

    raise "Failed to join domain with error #{result}" if result != 0
  end

  def self.compare_dns_names( dns_name1, dns_name2 )
    result = dns_name1.casecmp dns_name2
    result
  end

  private

  def get_native_computer_information
    WMI::Win32_ComputerSystem.find(:first)
  end
  
end
