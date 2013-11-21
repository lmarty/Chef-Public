#
# Cookbook Name:: zerovm
# Recipe:: debugger
#
# Copyright 2013, Heavy Water Operations, LLC
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

zerovm_env = {
  "ZEROVM_ROOT" => "#{node[:zerovm][:root]}",
  "ZRT_ROOT" => "#{node[:zerovm][:zrt_root]}",
  "ZVM_PREFIX" => "#{node[:zerovm][:home]}",
}

%w{
 flex
 bison
 groff
 libncurses5-dev
 libexpat1-dev
}.each do |pkg|
  package pkg
end

git "#{node[:zerovm][:toolchain]}/SRC/gdb" do
  repository node[:zerovm][:sources][:gdb]
end

directory "#{node[:zerovm][:toolchain]}/SRC/gdb/BUILD" do
  recursive true
end

execute "configure zerovm toolchain debugger build" do
  cwd "#{node[:zerovm][:toolchain]}/SRC/gdb/BUILD"
  command "../configure --program-prefix=x86_64-nacl-  --prefix=#{zerovm_env["ZVM_PREFIX"]}"
  environment zerovm_env
end

execute "build zerovm toolchain debugger" do
  cwd "#{node[:zerovm][:toolchain]}/SRC/gdb/BUILD"
  command "make -j4 && make install"
  environment zerovm_env
end
