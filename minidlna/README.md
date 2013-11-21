# minidlna cookbook
This cookbook installs and configures minidlna server.

# Requirements
No requirements

# Usage
Setup the required attributes and keep the "minidlna::node" recipe in the
run list.

# Attributes
The following are the attributes used by this cookbook.

* `node['minidlna']['audio_directories']` - Audio directories
* `node['minidlna']['video_directories']` - Video directories
* `node['minidlna']['picture_directories']` - Picture directories
* `node['minidlna']['db_dir']` - The database directory for minidlna
* `node['minidlna']['log_dir']` - The log directory for minidlna
* `node['minidlna']['log_level']` - The log level
* `node['minidlna']['port']` - The port to listen on
* `node['minidlna']['friendly_name']` - The friendly name to show to the clients
* `node['minidlna']['ionotify']` - Whether to use enable/disable ionotify. Valid values: 'yes' and 'no'
* `node['minidlna']['strict_dlna']` - Whether to enable strict dlna. Valid values: 'yes' and'no'
* `node['minidlna']['enable_tivo']` - Whether to enable tivo mode. Valid values: 'yes' and'no'
* `node['minidlna']['notify_interval']` - The ionotify interval to be used if ionotify is enabled


# Recipes

## minidlna::node
This recipe installs the minidlna package and configures based on the
attribtues given.

# Author

Author:: Kannan Manickam (<me@arangamani.net>)
