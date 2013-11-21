#
# Cookbook Name:: fanout
# Recipe:: default
#
# Copyright (C) 2013 Andrew Fecheyr
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

include_recipe "build-essential"

directory(node['fanout']['dir'])

remote_file "#{node['fanout']['dir']}/fanout.c" do
  source "https://github.com/travisghansen/fanout/raw/master/fanout.c"
  notifies :run, "execute[make_fanout]"
end

remote_file "#{node['fanout']['dir']}/Makefile" do
  source "https://github.com/travisghansen/fanout/raw/master/Makefile"
  notifies :run, "execute[make_fanout]"
end

execute "make_fanout" do
  command "make"
  cwd node['fanout']['dir']
  action :nothing
  notifies :restart, "service[fanout]"
end

link(node['fanout']['bin']) do
  to "#{node['fanout']['dir']}/fanout"
end

template "/etc/init/fanout.conf" do
  source "fanout.conf.erb"
  mode 0644
  options = %w{port run-as client-limit logfile max-logfile-size}.map do |opt|
    "--#{opt}=#{node['fanout'][opt]}" if node['fanout'][opt]
  end
  variables(:options => options.compact.join(' '))
  notifies :start, "service[fanout]"
end

service "fanout" do
  provider Chef::Provider::Service::Upstart
  supports :restart => true, :start => true, :stop => true, :status => true
  action :enable
end