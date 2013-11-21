#
# Cookbook Name:: minidlna
#
# Copyright (C) 2013 Kannan Manickam
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Audio directories
default['minidlna']['audio_directories'] = []

# Video directories
default['minidlna']['video_directories'] = []

# Picture directories
default['minidlna']['picture_directories'] = []

# The database directory for minidlna
default['minidlna']['db_dir'] = '/var/lib/minidlna'

# The log directory for minidlna
default['minidlna']['log_dir'] = '/var/log'

# The log level
default['minidlna']['log_level'] = 'info'

# The port to listen on
default['minidlna']['port'] = 8200

# The friendly name to show to the clients
default['minidlna']['friendly_name'] = 'My minidlna'

# Whether to use enable/disable ionotify. Valid values: 'yes' and 'no'
default['minidlna']['ionotify'] = 'yes'

# Whether to enable strict dlna. Valid values: 'yes' and'no'
default['minidlna']['strict_dlna'] = 'no'

# Whether to enable tivo mode. Valid values: 'yes' and'no'
default['minidlna']['enable_tivo'] = 'no'

# The ionotify interval to be used if ionotify is enabled
default['minidlna']['notify_interval'] = 895
