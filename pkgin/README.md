# Description

This cookbook is used to install packages on Unix systems with the pkgin utility.

# Requirements

Any system that uses pkgin *should* work, but I've only tested it on Joyent SmartOS

# Attributes

No attributes are set in the cookbook at the moment

# Resources/Providers

This cookbook implements a pkgin_package provider

## Actions
  :add: installs a package on the system
  :remove: removes a package from the system

# Usage

pkgin_package "emacs-nox11" do
  action :install
end

pkgin_package "joe" do
  action :remove
end

# License and Author
Author:: Sean OMeara (<someara@opscode.com>)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
