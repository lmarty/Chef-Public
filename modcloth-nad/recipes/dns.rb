#
# Cookbook Name:: nad
# Recipe:: dns
#
# Copyright (c) 2013 ModCloth, Inc.
#
# MIT License
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
# of the Software, and to permit persons to whom the Software is furnished to do
# so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

unless platform?('smartos', 'solaris2')
  Chef::Log.warn 'recipe[modcloth-nad::dns] only does stuff on SmartOS!'
end

include_recipe 'modcloth-nad::default'

template "#{node['nad']['prefix']}/etc/node-agent.d/smartos/dns_stats.sh" do
  source 'dns_stats.sh.erb'
  mode 0755
  notifies :run, 'execute[nad-update-index smartos]'
  only_if { platform?('smartos', 'solaris2') }
end

link "#{node['nad']['prefix']}/etc/node-agent.d/dns_stats.sh" do
  to "#{node['nad']['prefix']}/etc/node-agent.d/smartos/dns_stats.sh"
  notifies :restart, "service[#{node['nad']['service_name']}]"
  only_if { platform?('smartos', 'solaris2') }
end
