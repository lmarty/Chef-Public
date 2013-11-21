#
# Cookbook Name:: R
# Recipe:: default
#
# Copyright 2011, ModCloth, Inc.
#
# Authors: Manuel Gutierrez <m.gutierrez@modcloth.com>
# & Blake Irvin <b.irvin@modcloth.com>
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
RVERSION = "2.13.0"

remote_file "/tmp/R-#{RVERSION}.tar.gz" do
  source "http://cran.cnr.Berkeley.edu/src/base/R-2/R-#{RVERSION}.tar.gz"
  mode "0644"
  checksum "559213ff05a205b9d2ad7ac7abebf477fb87c1bb3f0b03febbff5aa6bd8ab811"
end

execute "unpack R source" do
  command "cd /tmp && gunzip R-#{RVERSION}.tar.gz && \
					 tar -xf R-#{RVERSION}.tar && cd R-#{RVERSION} && \
					 ./configure && make && make install"
  not_if "R --version | grep #{RVERSION}"
end

