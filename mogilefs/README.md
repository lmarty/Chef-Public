DESCRIPTION
===========

Installs MogileFS and includes LWRPs and definitions to configure trackers, hosts, devices, storage servers, settings, domains, and classes.

This cookbook was developed while following the setup instructions from Danga's [MogileFS - Install How To](http://code.google.com/p/mogilefs/wiki/InstallHowTo) Wiki article.

Requirements
============

* Chef 0.10
* Ubuntu 10.04

Please help increase the supported platform list by notifying me or submitting pull requests which will add support for other platforms.

Attributes
==========

* `mogilefs[:bin_path]` - Directory path to MogileFS binaries
* `mogilefs[:dir]` - Directory path to MogileFS specifics (configuration files, etc)
* `mogilefs[:user]` - Unprivileged user which will run MogileFS services
* `mogilefs[:mogilefsd][:conf_port]` - Port for trackers to listen on. Configurable for mogilefsd.conf
* `mogilefs[:mogilefsd][:listener_jobs]` - How many listener jobs. Configurable for mogilefsd.conf
* `mogilefs[:mogilefsd][:delete_jobs]` - How many delete jobs. Configurable for mogilefsd.conf
* `mogilefs[:mogilefsd][:replicate_jobs]` - How many replicate jobs. Configurable for mogilefsd.conf
* `mogilefs[:mogilefsd][:reaper_jobs]` - How many reaper jobs. Configurable for mogilefsd.conf
* `mogilefs[:mogilefsd][:mog_root]` - Location of MogileFSD data. Configurable for mogilefsd.conf
* `mogilefs[:mogstored][:http_listen]` - HTTP Listen string for storage server. Configurable for mogstored.conf
* `mogilefs[:mogstored][:mgmt_listen]` - MGMT Listen string for storage server. Configurable for mogstored.conf
* `mogilefs[:mogstored][:doc_root]` - Location of MogileFSD storage data. Configurable for mogstored.conf

Recipes
=======

default
-------

Configures a node to be a MogileFS server or client and sets up an unprivileged user for MogileFS. This recipe does not configure any of the components for a MogileFS setup.

Usage
=====

This cookbook does not contain generic recipes to configure trackers, databases, or storage nodes. Instead you are provided with definitions and LWRPs (documented below) to describe your MogileFS setup.

Since MogileFS is a requirement of an application, it is suggested that you define your own recipes within the application's cookbook to configure MogileFS datastores, trackers, and setup the MogileFS database. For example given the application `enmasse_online`, here are some recipes and what they implement:

  enmasse_online::mogilefs_datastore - configures a node to be a mogilefs datastore. Implements the mogilefs_datastore definition and mogilefs_device LWRP
  enmasse_online::mogilefs_tracker - configures a node to be a mogilefs tracker. Implements the mogilefs_tracker definition and mogilefs_setting definition to connect it to memcached. Implements the mogilefs_domain and mogilefs_klass LWRPs to setup a new application specific domain with an image, video and resource class.
  
Generic recipes may be added in the future, but it is strongly encouraged for you to think of MogileFS as a part of your application and not global infrastructure.

Definitions
===========

## mogilefs_database

Initializes a database for MogileFS

### Parameters
Name | Description | Default
-----|-------------|--------
root_username | username of database's root user | 
root_password | password of database's root user | 
host | ipaddress of database server | 
username | username of non-root user for mogilefs | 
password | password for non-root user for mogilefs |
type | type of database server | "MySQL"

### Example

    mogilefs_database "mogilefs" do
      root_username "root"
      root_password "supersecure"
      host "10.2.0.10"
      username "mogilefs"
      password "rhodeislandisnotanisland"
    end

## mogilefs_datastore

Configure a node to be a MogileFS storage node. See the [MogileFS Highlevel Overview](http://code.google.com/p/mogilefs/wiki/HighLevelOverview) for details.

### Parameters
Name | Description | Default
-----|-------------|--------
hostname | Hostname or name of storage node | name
ipaddress | IP Address for storage node  | 
port | HTTP Port of storage node | 
trackers | Array of trackers to notify | []
http_listen | HTTP Listen string for storage server | cookbook attribute
mgmt_listen | MGMT Listen string for storage server | cookbook attribute
owner | owner of service and files | "root"
group | group of service and files | "root"
cookbook | used to specify where the mogstored.conf is located | "mogilefs"
service_name | the name of the service to be defined | "mogstored"
runit_options | any additional runit service options. Refer to runit cookbook for details | {}

### Example

    mogilefs_datastore node[:fqdn] do
      ipaddress "10.0.2.20"
      port 7501
      trackers ["10.0.2.10:7001", "10.0.2.11:7001"]
    end

## mogilefs_setting

Set MogileFS settings by their key and value

### Paramters
Name | Description | Default
-----|-------------|--------
setting | Name of the setting to manipulate | name
value | Desired value of the setting  | 

### Example

#### Set trackers to use memcached

    mogilefs_setting "memcache_servers" do
      trackers ["10.0.2.10:7001", "10.0.2.11:7001"]
      value "10.0.2.30:11211, 10.0.2.31:11211"
    end

## mogilefs_tracker

Configure a node as a MogileFS tracker. See the [MogileFS Highlevel Overview](http://code.google.com/p/mogilefs/wiki/HighLevelOverview) for details.

### Parameters
Name | Description | Default
-----|-------------|--------
database | a hash of options which must specify the host, database, username, and password of the MogileFS 
owner | owner of configuration files | "root"
group | group of configuration files | "root"
cookbook | cookbook that contains the mogilefsd.conf | "mogilefs"
service_name | the name of the service to be defined | "mogilefsd"
runit_options | any additional runit service options. Refer to the runit cookbook for details | {}

### Example

#### Set up a new tracker server

    mogilefs_tracker "enmasse_online" do
      database(
        :host => "10.2.0.10"
        :database => "mogilefs",
        :username => "mogile",
        :password => "asecurepassword"
      )
    end

Resources And Providers
=======================

The default provider uses the [mogilefs-client gem](http://seattlerb.rubyforge.org/mogilefs-client/MogileFS/Admin.html) and the Danga supplied mogadm tool under the hood

## mogilefs_domain

Manages top level [domains](http://code.google.com/p/mogilefs/wiki/Glossary#domain) in MogileFS

### Actions
Action | Description | Default
-------|-------------|--------
create | Create a new domain | Yes
delete | Destroy the top level domain |

### Attributes
Attribute | Description | Default
----------|-------------|--------
domain | Name of the domain you wish to manage | name
trackers | Array of trackers to notify | 

### Examples

#### Create new domain

    mogilefs_domain "enmasse_online" do
      trackers ["10.0.2.10:7001", "10.0.2.11:7001"]
    end

## mogilefs_klass

Manages a [class](http://code.google.com/p/mogilefs/wiki/Glossary#class) of a domain in MogileFS

### Actions
Action | Description | Default
-------|-------------|--------
create | Create a new class | yes
update | Modifying a pre-existing class |
delete | Destroy a class |

### Attributes
Attribute | Description | Default
----------|-------------|--------
klass | Name of the class you wish to manage | name
domain | The domain this class will belong to | 
mindevcount | Set the [minimum replica count](http://code.google.com/p/mogilefs/wiki/Glossary#minimum_replica_count_%28mindevcount%29) for this class | 
trackers | Array of trackers to notify | 

### Examples

#### Create a new class

    mogilefs_klass "image" do
      trackers ["10.0.2.10:7001", "10.0.2.11:7001"]
      domain "enmasse_online"
      mindevcount 2
    end

## mogilefs_host

Manages a host in the MogileFS cluster. If you are trying to setup a datstore host, you probably don't want to use this directly. There is a definition to setup a mogilefs_datastore.

### Actions
Action | Description | Default
-------|-------------|--------
create | Create a new host | yes
update | Modifying a pre-existing host |
delete | Destroy a host |

### Attributes
Attribute | Description | Default
----------|-------------|--------
name | Hostname | name
ipaddress | IP Address of new host | 
port | HTTP port for new host | 
trackers | Array of trackers to notify | 
status | Set the status of the node | "alive"
args | Additional arguments to pass to [MogileFS::Admin](http://seattlerb.rubyforge.org/mogilefs-client/MogileFS/Admin.html) | {}

### Examples

#### Creating a new host

    mogilefs_host node[:fqdn] do
      ipaddress "10.0.2.15"
      port 7501
      trackers ["10.0.2.10:7001", "10.0.2.11:7001"]
      status "alive"
    end
    
## mogilefs_device

### Actions
Action | Description | Default
-------|-------------|--------
create | Create a new device | yes
alive | Mark a device as 'alive' |
down | Mark a device as 'down' |
dead | Mark a device as 'dead' |

### Attributes
Attribute | Description | Default
----------|-------------|--------
hostname | hostname of host to place device on | name
devid | Unique identifier for device | 
trackers | Array of trackers to notify | 

### Examples

#### Creating a new device

    mogilefs_device "enmasse_storage" do
      devid 1
      trackers ["10.0.2.10:7001", "10.0.2.11:7001"]
    end
    
Development
===========

* Source hosted at [GitHub](https://github.com/enmasse-entertainment/mogilefs-cookbook)
* Report issues/Questions/Feature requests on [GitHub Issues](https://github.com/enmasse-entertainment/mogilefs-cookbook/issues)

Pull requests are very welcome! Make sure your patches are well tested.
Ideally create a topic branch for every seperate change you make.

LICENSE and AUTHOR
==================

Author:: Jamie Winsor (<jamie@enmasse.com>)

Copyright:: 2011, En Masse Entertainment, Inc

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.