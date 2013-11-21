# Minecraft [![Build Status](https://secure.travis-ci.org/gregf/cookbook-minecraft.png)](http://travis-ci.org/gregf/cookbook-minecraft)

## Description

Installs and configures a [Minecraft](http://www.minecraft.net) server.

* Opscode Community Site: http://community.opscode.com/cookbooks/minecraft
* Source Code: http://github.com/gregf/cookbook-minecraft

## Requirements

### Chef

Tested on chef 11

### Cookbooks

* [java](http://community.opscode.com/cookbooks/java)
* [runit](http://community.opscode.com/cookbooks/runit)
* [python](http://community.opscode.com/cookbooks/python)
* [sudo](http://community.opscode.com/cookbooks/sudo)

### Platforms

* Debian 6+
* Ubuntu 12.04+
* Centos 6.4+

## Recipes

### default

The default recipe ensures a vanilla minecraft is installed, and configured based on attributes you have specified.

### user

The user recipe is called by default, and creates a new user/group `mcserver` for the server to run as.

### service

The service recipe enables the service for runit or mark2 depending on the `install_type` attribute. Defaults to `mark2`

### mark2

[Mark2](https://github.com/mcdevs/mark2) is installed by default as a server wrapper. You can modify the `install_type` attribute to use runit if prefered.

## Attributes

### Default

* `minecraft['user']`
  - The user the minecraft server runs under, default `mcserver`

* `minecraft['group']`
  - The group the minecraft server runs under, default `mcserver`

* `minecraft['install_dir']`
  - The default location minecraft is installed to, default `/srv/minecraft`

* `minecraft['base_url']`
  - The base url to fetch minecarft releases from, default `https://s3.amazonaws.com/Minecraft.Download/versions`

* `minecraft['jar']`
  - The name of the jar file to fetch, default `minecraft_server`

* `minecraft['version']`
  - The version of minecraft server you want, default `1.6.4`

* `minecraft['checksum']`
  - The sha256 checksum of minecraft_server.jar

* `minecraft['xms']`
  - The minimum ammount of ram java allow minecraft to consume, default `512M`

* `minecraft['xmx']`
  - The maximum ammount of ram java allow minecraft to consume, default `512M`

* `minecraft['java-options']`
  - You can use this to pass additional options to java, default blank

* `minecraft['init_style']`
  - Current you can choose between the mark2 server wrapper and runit, default `mark2`

* `minecraft['banned-ips']`
  - An array of ips you would like banned, default blank

* `minecraft['banned-players']`
  - An array of players you would like banned, default blank

* `minecraft['white-list-users']`
  - An array of users you would like to white-list, default blank

* `minecraft['ops']`
  - An array of admins, default blank

### Properties

You can can customize any of the settings from server.properties. They are kept up to date with upstream and you can read about each setting in more
detail [here](http://minecraft.gamepedia.com/Server.properties#Minecraft_server_properties)

### Example

`node['minecraft']['properties']['seed'] = "chef"`

### Mark2

You can see a full list of possible mark2 settings, and their default values
[here](https://raw.github.com/mcdevs/mark2/master/mk2/resources/mark2.default.properties).

You can adjust one of three hashes to change any of the settings for mark2.

### Hashes

```ruby
minecraft['mark2']['properties']
minecraft['mark2']['java']
minecraft['mark2']['plugin']
```

### Examples

```ruby
node.set['mark2']['properties'] = {
  'shutdown-timeout' => '60'
  'log.rotate-mode' => 'daily'
}

node.set['mark2']['java'] = {
  'cli.X.incgc' => 'true'
}

node.set['mark2']['plugin'] = {
  'backup.enabled' => 'false'
}
```

> **NOTE** By default both java.cli.X.ms and java.cli.X.mx are set to match the values in the default attributes file.

### Known issues

Minecraft internally regenerates all of its configuration files every startup. The order of server.properties sometimes changes, timestamps are
and headers are injected into all the configuration files.

This in turn causes chef to notice configuration files have been changed and will automatically restart the server again to pick up those changes. This may
cause your server to restart frequently, without notice.

This leaves you with two work arounds for now.

1. Only run chef-client once a day or manually as  you need to.
2. Set minecraft['autorestart'] = false and restart minecraft manually when you make configuration changes.

I am hoping I can get this changed upstream. I will attempt to come up with a better work around in the mean time.

##Contributing

1. Fork it
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Added some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create new Pull Request

##License

Author: Greg Fitzgerald <greg@gregf.org>  
Author: Sean Escriva <sean.escriva@gmail.com>  

Copyright 2013, Greg Fitzgerald.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
