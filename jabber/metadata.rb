maintainer       "Ernie Brodeur"
maintainer_email "ebrodeur@ujami.net"
license          'Apache v2.0'
description      "Provides an XMPP server via ejabberd"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.2"
depends          "erlang"

recipe "openvpn", "Installs and configures ejabberd"

grouping 'jabber/global',
	:title => "Global options",
	:description => 'Set options that affect the server itself.'
attribute "jabber/global/loglevel",
  :display_name => "The jabber daemon's Loglevel",
  :description => "0 = none, - 5 = debug",
  :default => "4",
  :choice => %w{0 1 2 3 4 5}
