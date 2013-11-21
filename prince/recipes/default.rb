#
# Cookbook Name:: prince
# Recipe:: default
#
# Copyright 2011, O'Reilly Media, Inc.
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


arch =
  case node[:kernel][:machine]
  when "x86_64" then "amd64"
  else node[:kernel][:machine]
  end

sums = {
  "amd64" => "96691f7240ba0eb13ee7105d95a99aa8fdd31223c50d39656970f758c823ccd1",
  "i386" => "43b60fe39123de2a0e7653128dc27e1f2943b0db38dcdb56e28e7c9cca1ff6a3",
}

file = "prince_8.0-1ubuntu10.04_#{arch}.deb"
remote_file "/tmp/#{file}" do
  source "http://www.princexml.com/download/#{file}"
  mode "0644"
  checksum sums[arch]
  action :create_if_missing # the file's kinda big
end


# required by Prince
package "libgif4"
package "libtiff4"
package "libfontconfig1"
package "libcurl3"

dpkg_package "prince" do
  source "/tmp/#{file}"
  action :install
end

cookbook_file "/usr/lib/prince/license/license.dat" do
  backup 100
  mode "0444"
  cookbook node[:prince][:license_cookbook]
end
