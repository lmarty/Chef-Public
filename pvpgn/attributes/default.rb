# Supported db types: none|mysql|pgsql
default['pvpgn']['db_type'] = "mysql"

# Set to 'yes' to install latest version from source
default['pvpgn']['install_latest_from_source'] = "no"

# Set conf dir. /etc/pvpgn if pvpgn is installed
# via package manager. /opt/pvpgn/etc if installed
# from source.
default['pvpgn']['conf_dir'] = "/etc/pvpgn"

# Set the following to configure a Diablo II
# closed realm server

############ Configure d2cs.conf ############
default['pvpgn']['realmname'] = "D2CS"

# Set realm type
default['pvpgn']['lod_realm'] = "2"

# WARNING!! DO NOT USE "127.0.0.1" or "localhost" !!!
default['pvpgn']['d2cs_servaddrs'] = "0.0.0.0:6113"

# YOU MUST CHANGE THIS OR D2CS WON'T WORK PROPERLY
# WARNING!! DO NOT USE "127.0.0.1" or "localhost" !!!
default['pvpgn']['d2cs_gameservlist'] = "<d2gs-IP>,<another-d2gs-IP>"

# YOU MUST CHANGE THIS OR D2CS WON'T WORK PROPERLY
# WARNING!! DO NOT USE "127.0.0.1" or "localhost" !!!
default['pvpgn']['bnetdaddr'] = "<bnetd-IP>:6112"

default['pvpgn']['d2cs_loglevels'] = "fatal,error,warn,info,debug,trace"
# End configure of d2cs.conf

############ Configure realm.list #############
# YOU MUST CHANGE THIS OR D2CS WON'T WORK PROPERLY
default['pvpgn']['reaml_list'] = "\"D2CS\"\t\t\t\t\"PvPGN Closed Realm\"\t\t\t\t1.2.3.4:6113"
########### End configure of realm.list #######

############ Configure d2dbs.conf#############
# Only necessary if using MySQL or PostgreSQL
# WARNING!! DO NOT USE "127.0.0.1" or "localhost" !!!
default['pvpgn']['d2dbs_servaddrs'] = "0.0.0.0:6114"

# YOU MUST CHANGE THIS OR D2DBS WON'T WORK PROPERLY
# WARNING!! DO NOT USE "127.0.0.1" or "localhost" !!!
default['pvpgn']['d2dbs_gameservlist'] = "<d2gs-IP>,<another-d2gs-IP>"

default['pvpgn']['d2dbs_loglevels'] = "fatal,error,warn,info,debug,trace"
##############End Configure d2dbs.conf#################
