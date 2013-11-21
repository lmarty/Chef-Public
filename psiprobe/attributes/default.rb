#
# Cookbook Name:: psiprobe
# Attributes:: default
#
# License :  GNU GPL v2
#
# Copyright 2011, FLEETING CLOUDS
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
# 
#
default[:psiprobe][:version] = "2.3.1"
default[:psiprobe][:tomcat_home] = "/var/lib/tomcat6"
default[:psiprobe][:tomcat_conf] = "/etc/tomcat6"
default[:psiprobe][:define_manager] = "false"
default[:psiprobe][:manager_uid] = "prober"
default[:psiprobe][:manager_pwd] = "ps1pr0bING"

default[:psiprobe][:mirror] = "http://psi-probe.googlecode.com/files"

