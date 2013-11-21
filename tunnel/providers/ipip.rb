#
# Provider:: tunnel_ipip
# Author:: Guilhem Lettron <guilhem.lettron@youscribe.com>
#
# Copyright 2013, YouScribe.
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
# Support whyrun
def whyrun_supported?
  true
end

def load_current_resource
  @current_resource = Chef::Resource::TunnelIpip.new(@new_resource.name)
  @current_resource.name(@new_resource.name)
  @current_resource.tunnel_name(@new_resource.tunnel_name)
  @current_resource.host(@new_resource.host)
  @current_resource.remote(@new_resource.remote)
  @current_resource.local(@new_resource.local)
  @current_resource.interface(@new_resource.interface)
  @current_resource.ttl(@new_resource.ttl)
  @current_resource.started = true if tunnel_started?
  @current_resource.installed = true if tunnel_installed?(@current_resource.host, @current_resource.remote)
end

action :create do
  if @current_resource.started
    Chef::Log.info "#{ @current_resource } already started."
  else
    create_tunnel
  end
end

action :install do
  if @current_resource.installed
    Chef::Log.info "#{ @current_resource } already installed."
  elsif @current_resource.started
    Chef::Log.info "#{ @current_resource } already started. We will only install it"
    install_tunnel
  else
    install_tunnel
    create_tunnel
  end
end

def tunnel_started?
  cmd = "ip tunnel show"
  ip = Mixlib::ShellOut.new(cmd)
  ip.run_command
  ip.stdout.each_line { |tunnel| return true if tunnel_equal?(tunnel) }
  return false
end

def tunnel_equal?(tunnel)
  tunnel.include?("ip/ip") && tunnel.include?("#{tunnel_name}:") && tunnel.include?("remote #{new_resource.remote}")
end

def install_tunnel
  true
end

def tunnel_installed?(host, remote)
  false
end

def tunnel_name
  if new_resource.tunnel_name
    return new_resource.tunnel_name
  else
    return "tun_#{new_resource.host}"
  end
end

def create_tunnel
  cmd = "ip tunnel add"
  cmd += " #{tunnel_name}"
  cmd += " mode ipip"
  cmd += " remote #{@current_resource.remote}"
  cmd += " local #{@current_resource.local}" if @current_resource.local
  cmd += " ttl #{@current_resource.ttl}" if @current_resource.ttl
  cmd += " dev #{@current_resource.interface}"
  execute cmd
end
