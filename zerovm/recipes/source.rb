#
# Cookbook Name:: zerovm
# Recipe:: source
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

include_recipe "build-essential"
include_recipe "git"

zerovm_env = {
  "ZEROVM_ROOT" => "#{node[:zerovm][:root]}",
  "ZRT_ROOT" => "#{node[:zerovm][:zrt_root]}",
  "ZVM_PREFIX" => "#{node[:zerovm][:home]}",
}

%w{
  libc6-dev-i386
  libglib2.0-dev
  pkg-config
  git
  libzmq-dev
  automake
  autoconf
  libtool
  g++-multilib
  texinfo
}.each do |pkg|
  package pkg
end

git_sources = node[:zerovm][:sources]
git node[:zerovm][:root] do
  repository git_sources[:zerovm]
end

git "#{node[:zerovm][:root]}/valz" do
  repository git_sources[:validator]
end

git node[:zerovm][:zrt_root] do
  repository git_sources[:zrt]
end

git node[:zerovm][:toolchain] do
  repository git_sources[:toolchain]
end

%w[linux-headers-for-nacl gcc glibc newlib binutils].each do |repo|
  git "#{node[:zerovm][:toolchain]}/SRC/#{repo}" do
    repository git_sources[repo]
  end
end

directory zerovm_env["ZVM_PREFIX"]

execute "build zerovm validator" do
  cwd "#{node[:zerovm][:root]}/valz"
  command "make validator"
  environment zerovm_env
  not_if { ::Dir.exists?(node[:zerovm][:root] + "/valz/out/Release") }
  notifies :run, "execute[install zerovm validator]", :immediately
end

execute "install zerovm validator" do
  cwd "#{node[:zerovm][:root]}/valz"
  command "make install"
  environment zerovm_env
  not_if { ::File.exists? "/usr/bin/valz" }
  action :nothing
end

execute "install zerovm" do
  cwd "#{node[:zerovm][:root]}"
  command "make && make install PREFIX=#{zerovm_env["ZVM_PREFIX"]}"
  environment zerovm_env
  not_if { ::File.exists? "#{node[:zerovm][:home]}/bin/zerovm" }
end

execute "build zerovm toolchain" do
  cwd node[:zerovm][:toolchain]
  command "make -j8"
  environment zerovm_env
end

include_recipe "zerovm::debugger" if node[:zerovm][:debugger]
