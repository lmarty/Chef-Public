#
# Cookbook Name:: mogilefs
# Definition:: mogilefs_tracker
#
# Author:: Jamie Winsor (<jamie@enmasse.com>)
#
# Copyright 2011, En Masse Entertainment, Inc.
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

define :mogilefs_tracker, :database => { :host => nil, :port => nil, :timeout => nil, :username => nil, :password => nil }, :owner => "root", :group => "root", :cookbook => "mogilefs", :service_name => nil, :runit_options => Hash.new do
  require_recipe "mogilefs"
  require_recipe "runit"
  
  params[:service_name] ||= "mogilefsd"
  params[:database][:port] ||= 3306
  params[:database][:timeout] ||= 5
  
  params[:conf_port] ||= node[:mogilefs][:mogilefsd][:conf_port]
  params[:listener_jobs] ||= node[:mogilefs][:mogilefsd][:listener_jobs]
  params[:delete_jobs] ||= node[:mogilefs][:mogilefsd][:delete_jobs]
  params[:replicate_jobs] ||= node[:mogilefs][:mogilefsd][:replicate_jobs]
  params[:reaper_jobs] ||= node[:mogilefs][:mogilefsd][:reaper_jobs]
  params[:mog_root] ||= node[:mogilefs][:mogilefsd][:mog_root]
  
  runit_options = params[:runit_options]
  runit_options[:cookbook] ||= params[:cookbook]
  runit_options[:template_name] ||= 'mogilefsd'
  runit_options[:run_restart] ||= true
  runit_options[:options] = Hash.new unless runit_options.has_key?(:options)
  runit_options[:options].merge!(:conf_path => "#{node[:mogilefs][:dir]}/#{params[:service_name]}.conf")
  
  template "#{node[:mogilefs][:dir]}/#{params[:service_name]}.conf" do
    source "mogilefsd.conf.erb"
    cookbook params[:cookbook]
    owner params[:owner]
    group params[:group]
    mode 0644
    variables(
      :database => params[:database],
      :conf_port => params[:conf_port],
      :listener_jobs => params[:listener_jobs],
      :delete_jobs => params[:delete_jobs],
      :replicate_jobs => params[:replicate_jobs],
      :reaper_jobs => params[:reaper_jobs],
      :mog_root => params[:mog_root]
    )
    notifies :restart, "service[#{params[:service_name]}]"
  end

  runit_service params[:service_name] do
    cookbook runit_options[:cookbook]
    template_name runit_options[:template_name]
    options runit_options[:options]
    run_restart runit_options[:run_restart]
    directory runit_options[:directory] if runit_options.has_key?(:directory)
    only_if runit_options[:only_if] if runit_options.has_key?(:only_if)
    control runit_options[:control] if runit_options.has_key?(:control)
    active_directory runit_options[:active_directory] if runit_options.has_key?(:active_directory)
    owner runit_options[:owner] if runit_options.has_key?(:owner)
    group runit_options[:group] if runit_options.has_key?(:group)
    start_command runit_options[:start_command] if runit_options.has_key?(:start_command)
    restart_command runit_options[:restart_command] if runit_options.has_key?(:restart_command)
    status_command runit_options[:status_command] if runit_options.has_key?(:status_command)
    env runit_options[:env] if runit_options.has_key?(:env)
    notifies :start, "service[#{params[:service_name]}]", :immediately
  end
end
