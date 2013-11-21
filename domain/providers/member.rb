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
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
# implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Support whyrun
def whyrun_supported?
  true
end

computer_information = ComputerInformation.new

action :set do
  current_computer_name = computer_information.get_computer_name
  current_domain_name = computer_information.get_computer_dns_domain

  computer_name_changed = ( ComputerInformation.compare_dns_names(current_computer_name, new_resource.name) != 0 )
  domain_name_changed = ( ComputerInformation.compare_dns_names(current_domain_name, new_resource.domain) != 0 )

  if ( computer_name_changed || domain_name_changed )
    converge_by("Set #{ new_resource }") do
      update_computer_name computer_information if computer_name_changed
      update_domain computer_information if domain_name_changed
    end
  end
end

def update_computer_name(computer_information)
  computer_information.set_computer_name( new_resource.name, new_resource.domain_user, new_resource.domain_password )
end

def update_domain(computer_information)
  computer_information.set_computer_dns_domain(
    new_resource.domain,
    new_resource.domain_user,
    new_resource.domain_password,
    new_resource.organizational_unit)
end




