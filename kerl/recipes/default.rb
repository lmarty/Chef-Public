#
# Cookbook Name:: kerl
# Recipe:: default
#
# Copyright 2011, Daniel Schauenberg
#

script "install kerl from github" do
  interpreter "bash"
  kerl = "#{node['kerl']['installpath']}/kerl"
  code <<-EOS
    curl -sLf https://raw.github.com/spawngrid/kerl/master/kerl -o #{kerl}
    chmod +x #{kerl}
  EOS
  not_if "test -f #{kerl}"
end

script "update kerl release list" do
  interpreter "bash"
  code <<-EOS
    #{node['kerl']['installpath']}/kerl update releases
  EOS
end

script "install default erlang: #{node['kerl']['erlversion']}" do
  interpreter "bash"
  kerl_bin = "#{node['kerl']['installpath']}/kerl"
  erlver = "#{node['kerl']['erlversion']}"
  inst_dir = "#{node['kerl']['defaultinstall']}"
  code <<-EOS
    #{kerl_bin} build #{erlver} default
    #{kerl_bin} install default #{inst_dir}
  EOS
  not_if "test -d #{node['kerl']['defaultinstall']}"
end

script "source default erlang install in .profile" do
  interpreter "bash"
  code <<-EOS
    echo 'source #{node['kerl']['defaultinstall']}/activate' >> #{ENV['HOME']}/.profile
  EOS
  not_if "grep installs/default #{ENV['HOME']}/.profile"
end

