#
# Cookbook Name:: getaddrinfo
# Recipe:: examples
#
# Copyright 2013, Heavy Water Operations, LLC.
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

getaddrinfo_label "one" do
  mask "fc00::/7"
  value 6
end

getaddrinfo_label "two" do
  mask "2001:0::/32"
  value 7
end

getaddrinfo_precedence "prefer ipv4" do
  mask "::ffff:0:0/96"
  value 100
end

getaddrinfo_scope "scoped" do
  mask "::ffff:0.0.0.0/96"
  value 14
end
