#
# Cookbook Name:: mpd
# Recipe:: scrobbler
#
# Copyright 2011, Chris Peplin
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

package "mpdscribble"

service "mpdscribble" do
  action :enable
end

lastfm = search(:auth, "id:lastfm")

template "/etc/mpdscribble.conf" do
  source "mpdscribble.conf.erb"
  mode "0644"
  variables :lastfm => lastfm[0]
  notifies :restart, resources(:service => "mpdscribble")
end if lastfm.length > 0
