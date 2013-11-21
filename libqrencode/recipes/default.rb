#
# Cookbook Name:: libqrencode
# Recipe:: default
#
# Copyright 2013, KRAY Inc.
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
require 'mkmf'
require 'tmpdir'

unless have_header('qrencode.h') && have_library('qrencode', 'QRinput_new')
  version = '3.4.2' # how can I get this from metadata?
  basename = "qrencode-#{version}"
  archive = "#{basename}.tar.gz"
  dir = Dir.tmpdir

  remote_file "#{dir}/#{archive}" do
    source "http://fukuchi.org/works/qrencode/#{archive}"
    checksum 'cca5c809c3799e6d1edc35e1d6e0957e93928de8b05da6c11b9c6afac1c8fde8'
  end

  bash 'install_qrencode' do
    cwd dir
    code <<-END
      tar xzf #{archive} && cd #{basename} && ./configure && make && make install
    END
  end
end
