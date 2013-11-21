#
# Cookbook Name:: skype
# Recipe:: default
#
# Copyright 2012, Arun Tomar
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


execute "yum-update" do
  command "yum update"
end

dependencies = %w{alsa-lib.i686 fontconfig.i686 freetype.i686 glib2.i686 libSM.i686 libXScrnSaver.i686 libXi.i686 libXrandr.i686 libXrender.i686 libXv.i686 libstdc++.i686 pulseaudio-libs.i686 qt.i686 qt-x11.i686 zlib.i686}

dependencies.each do |pkg|
  yum_package pkg do
    action :install
  end
end

directory node[:skype][:install_dir] do
  owner "root"
  group "root"
  mode "0755"
  action :create
  not_if "Dir.exists?(#{node[:skype][:install_dir]})"
end

#download skype
bash "download_skype" do
  user "root"
  cwd node[:skype][:temp_dir]
  code <<-EOH
  wget -c #{node[:skype][:url]} -O #{node[:skype][:filename]}
  tar xvf #{node[:skype][:filename]} -C #{node[:skype][:install_dir]} --strip-components=1
  EOH
end

link "/usr/share/applications/skype.desktop" do
  to "#{node[:skype][:install_dir]}"+"/"+"skype.desktop"
end

link "/usr/share/icons/skype.png" do
  to "#{node[:skype][:install_dir]}"+"/"+"icons/SkypeBlue_48x48.png"
end

link "/usr/share/pixmaps/skype.png" do
  to "#{node[:skype][:install_dir]}"+"/"+"icons/SkypeBlue_48x48.png"
end

template "/usr/bin/skype" do
  owner "root"
  group "root"
  mode "0755"
  source "skype.erb"
end
