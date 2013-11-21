Description
===========
Light weight resource to deliver archived application to your host.

Requirements
============
- tar

Attributes
==========

Usage
=====

    # fetch archive from remote host 
    # unpack archive in destination directory (see `base` parameter in `Resource's parameters` section)
    # create symlink 'my-application' pointing to unpacked archive  

    web_application 'my-application' do
        url   'http://some.ftp.host/my-app-v0.0.1.tar.gz'
        user  'alex'
        group 'users'
        action :deliver
    end

    # delete all unpacked archives matching glob pattern
    web_application 'my-application' do
        pattern   'my-app*/'
        user  'alex'
        group 'users'
        action :clean
    end

    # delete symlinked unpacked archive
    web_application 'my-application' do
        user  'alex'
        group 'users'
        action :delete
    end
    
Resource's parameters
=====================

 - `name` - name of symlink to point to unpacked archive
 - `url` - http url for application archive
 - `user` - owner of application files
 - `group` - group of applications files
 - `base` - directory where archive will be unpacked, default value is `user's home directory`. Archive will be unpacked in `base/apps/` directory. 
 `base/apps/name` will point to unpacked archive
 

Actions
=======
 - `fetch` - fetch archive from remote host and store it in `base/apps/`
 - `unpack` - unpack archive (see `override mode` section)
 - `symlink` - make symlink in `base/apps/` pointing to the archive unpacked 
 - `deliver` - fetch, unpack, symlink actions successively
 - `delete` - delete symlinked unpacked archive
 - `clean` - delete all unpacked archives matching glob pattern (symlinked unpacked archive is excluded)

Override mode
=============
When doing `unpack` action if archive is already unpacked -  delete current unpacked archive first. By default `override` is set to `true`.

    web_application 'my-application' do
        url   'http://some.ftp.host/my-app.tar.gz'
        user  'alex'
        group 'users'
        override true
        action :deliver
    end


 
 

