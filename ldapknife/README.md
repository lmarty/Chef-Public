Travis-ci status: [![Build Status](https://secure.travis-ci.org/jackl0phty/opschef-cookbook-ldapknife.png?branch=master)](http://travis-ci.org/jackl0phty/opschef-cookbook-ldapknife)
 

DESCRIPTION
===========

* __ldapknife.pl__ is a command-line utility mainly used to do mass deletions
from an OpenLDAP/AD directory by building an LDIF on-the-fly and using it as input.

* __ldapknife.pl__ will be mostly useful during the test/dev phase of building
an OpenLDAP directory.

* You may also find it useful when doing mass deletions or purging of old
data from an OpenLDAP directory.

ATTRIBUTES
==========

- There are currently no attributes for this cookbook.

USAGE
=====

The primary function of ldapknife.pl is to delete ALL distinguished names ( e.g. DNs ) from a given search base.
This option is envoked by the __--delall__ option. __NOTE:__ __--delall__ requires __-b__, __-D__, __-H__ & __--obj__ options to be given.

You can also execute __./ldapknife.pl --help__ for the help menu.

EXAMPLE1: __./ldapknife.pl --delall yes -D "cn=Manager,dc=example,dc=com" -b "cn=TestUsers,dc=example,dc=com" -H ldap://ldap.example.com --obj objectclass=person  --dir /tmp -w SECRET_PASS_HERE__

In EXAMPLE1, ldapknife.pl will __DELETE ALL__ objects of type person in the container __cn=TestUsers,dc=example,dc=com__ by connecting to ldap server __ldap://ldap.example.com__, 
building the file __/tmp/delete_ldif.ldif__ and using it as input to build another LDIF which will contain changtype:delete for each DN found in the TestUsers container.
The password for the admin account __"cn=Manager,dc=example,dc=com"__ is specified with the __-w__ option.

NOTE: If the __--dir__ option is not given, files __delete_all_dn_formatted.ldif__, __delete_all_dn.ldif__, __deleteAllDN.ldif__, and __delete_ldif.ldif__ will get written to __PWD__.

NOTE ABOUT *.LDIF FILES
=======================

* __delete_dn.ldif__ - LDIF produced by calling __ldapsearch__and passing it required parameters.
* __delete_all_dn_formatted.ldif__ - Same as __delete_dn.ldif__ with line wrapping removed.
* __delete_all_dn.ldif__ - LDIF of all DNs from __delete_all_dn_formatted.ldif__ of __changetype:delete__.
* __deleteAllDN.ldif__ - Same as __delete_all_dn.ldif__ with last blank line removed.

TO-DO-LIST
==========

* Implement ability to backup an OpenLDAP directory using __slapcat__.
* Implement ability to delete OpenLDAP database transaction database logs using __slapd_db_archive__.
