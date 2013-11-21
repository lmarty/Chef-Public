# Media Chef Cookbook
[![Build Status](https://travis-ci.org/arangamani-cookbooks/media.png?branch=master)](https://travis-ci.org/arangamani-cookbooks/media)


This cookbook will setup the media devices on a server which will ideally act
as a file/media server. Initially it will be used to mount external devices and
add then as NFS shares.

# Requirements
This cookbook requires devices to be preformatted to a file system. It will not
format the devices. It will simply mount the specified devices for using as a
file/media server.

For cookbook dependencies/requirements see `metadata.rb`.

# Usage

## For setting up the media devices

Prepare the `node['media']['devices']` node attribute and use the
`media::default` or `media::mount_devices` recipe. There is no need for
specifying the file system types. It is automatically detected and used for
mounting the devices. Devices can also be specified by `uuid` and `label`.

```ruby
# Prepare the media devices
node.set['media']['devices'] = {
  '/dev/sdb1' => '/mnt/videos',
  '/dev/disk/by-uuid/C398398878' => '/mnt/movies',
  '/dev/disk/by-label/songs' => '/mnt/songs'
}

# Include the recipe
include_recipe "media::default"
```

### Pro Tip
It is recommended that you set up the devices by UUID because the device
location cannot always be the same and can lead to confusion. The UUID and
label can be found using the `blkid` command on Unix. This command will give
the label, uuid, and the file system type.

Example:
```bash
$ sudo blkid /dev/sdb1
$ /dev/sdb1: LABEL="movies" UUID="C60475200468787521" TYPE="ntfs"
```

## For setting up the NFS shares

By default the mounted devices mount points are used for setting up the NFS
shares. It can be overridden by setting the `node['media']['nfs']['shares']`
node attribute. Then run the `media::setup_nfs_shares` recipe.

# Attributes

* `node['media']['devices']` - The media devices to mount
* `node['media']['user']` - The user to be used for media mount points
* `node['media']['group']` - The group to be used for media mount points
* `node['media']['nfs']['shares']` - The NFS shares to setup
* `node['media']['nfs']['network']` - The NFS network address to share with
* `node['media']['nfs']['writable']` - The writeable property of NFS share
* `node['media']['nfs']['sync']` - The sync property of NFS share
* `node['media']['nfs']['options']` - The options to be used for the NFS share

# Recipes

## media::default
This is the default recipe. It just runs the `media::mount_devices` recipe.

## media::mount_devices
This recipe mounts the specified media devices in the mount points given. See
Usage for more details.

## media::setup_nfs_shares
This recipe installs the requied packages for NFS server and sets up the nfs
shares.

## media::setup_minidlna
This recipe sets up the minidlna media server. Example for setting this up:
```ruby
node.set['minidlna']['video_directories'] = [
  '/media/storage/movies',
  '/media/storage/shows'
]
node.set['minidlna']['friendly_name'] = "Kannan's minidlna"
include_recipe "media::setup_minidlna"
```

# Author

Author:: Kannan Manickam (<me@arangamani.net>)
