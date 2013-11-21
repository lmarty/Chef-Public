#
# Cookbook Name:: linux-dev-env
# Recipe:: android 
#
# Copyright 2012, Gerald L. Hevener Jr., M.S.
#

# Download the Android SDK
script "download-android-sdk" do
  interpreter "bash"
  user "root"
  cwd node['linux-dev-env']['android_sdk_install_dir']
  code <<-EOH
  cd #{node['linux-dev-env']['android_sdk_install_dir']}
  wget http://dl.google.com/android/android-sdk_#{node['linux-dev-env']['android_sdk_version']}-linux.tgz
  EOH
  not_if "test -f #{node['linux-dev-env']['android_sdk_install_dir']}/android-sdk_#{node['linux-dev-env']['android_sdk_version']}-linux.tgz"
end

# Untar android SDK
script "untar-android-sdk" do
  interpreter "bash"
  user "root"
  cwd node['linux-dev-env']['android_sdk_install_dir']
  code <<-EOH
  cd #{node['linux-dev-env']['android_sdk_install_dir']}
  tar zxvhf #{node['linux-dev-env']['android_sdk_install_dir']}/android-sdk_#{node['linux-dev-env']['android_sdk_version']}-linux.tgz
  EOH
  not_if "test -d #{node['linux-dev-env']['android_sdk_install_dir']}/android-sdk-linux"
end

# Set permissions on Android SDK
script "set-permissions-on-android-sdk" do
  interpreter "bash"
  user "root"
  cwd node['linux-dev-env']['android_sdk_install_dir']
  code <<-EOH
  chown -R #{node['linux-dev-env']['android_user']}:#{node['linux-dev-env']['android_group']} #{node['linux-dev-env']['android_sdk_install_dir']}/android-sdk-linux
  EOH
  not_if "ls -al #{node['linux-dev-env']['android_sdk_install_dir']}/android-sdk-linux |grep #{node['linux-dev-env']['android_user']}"
end

# Install ia32-libs on x86_64 arch 
package "ia32-libs" do
  action :install
  only_if { node['target_cpu'] == "x86_64" }
end  
