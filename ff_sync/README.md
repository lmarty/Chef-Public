Description
===========

Installs and sets up a firefox sync server built by mozilla foundation.

Syncs optionally
- Bookmarks
- Passwords
- Tabs
- Addons
- Preferences
- History

Requirements
============

mysql and database cookbooks
mercurial for checkout

Attributes
==========

Directory where ff_sync is checked out
node['ff_sync']['server_dir'] = "/srv/ff_sync"

Mailserver where ff_sync sends mails to
node['ff_sync']['mailserver'] = "mail.#{node['domain']}"

Usage
=====

Just include recipe or setup the attributes mentioned before.

Ideas/Todo
==========

- Configure nginx correctly

Contact
=======
see metadata.rb

