################
### General configurations for default setup. Please override configurations below in the environment
### configurations where environment values are different.
###############
default['atg']['app_server'] = "jboss"  ### jboss or weblogic
default['atg']['home_dir'] = "/usr/local/jboss"
default['atg']['app_version'] = "jboss-eap-5.1"
default['atg']['app_home'] = "#{node.atg.home_dir}/#{node.atg.app_version}/jboss-as"
default['atg']['user'] 	= "jboss"
default['atg']['group'] = "jboss"
default['atg']['bind_ip'] = "0.0.0.0"
default['atg']['environment'] = "dev"
default['atg']['java_home'] = "/usr/lib/jvm/jdk1.6.0_24"
default['atg']['instances'] = [ "store-a", "ca-b", "stage-c" ]
default['atg']['use_staging'] = true
default['atg']['cluster'] = false
default['atg']['liveconfig'] = "off"
default['atg']['dl_url'] = "http://www.URLtoStorage.com/files"  
default['atg']['ojdbc'] = "ojdbc6.jar" ## provide ojdbc jar filename - needs to be stored in above file storage.

# ATG configuration files properties for run.conf
# Should be dynamic based on environment.
default['atg']['xms'] = "1024m"  
default['atg']['xmx'] = "1024m"
default['atg']['max_perm'] = "128m"
default['atg']['threadstack'] = "512"  #Thread stack size - best to limit to avoid running out of memory. Suggested 256 by ATG
default['atg']['store']['module_list'] = "DafEar.Admin,B2CCommerce,DCS.PublishingAgent"
default['atg']['stage']['module_list'] = "DafEar.Admin,B2CCommerce,DCS.PublishingAgent"
default['atg']['ca']['module_list'] = "DafEar.Admin,DPS.InternalUsers,B2CCommerce.Versioned,DCS-UI,DCS-UI.Versioned,PubPortlet,SiteAdmin,SiteAdmin.Versioned,DPS-UI,BIZUI,DCS.CustomCatalogs.Versioned"
default['atg']['lock']['module_list'] = "DafEar.Admin,DSS"

## ATG Logging configuration
default['atg']['logpath'] = "/data/logs"
default['atg']['log_enabled'] = "false"
default['atg']['log_sched'] = "* * * * 23 00"
default['atg']['log_arch']  = 7

## Infrastructure configurations - default for single server workstation
## Environment configurations will handle clustered environments.
default['atg']['store']['lockmanager'] = "localhost" # set to primary lock manager lock1 below
default['atg']['store']['lock_port'] = "9010"
default['atg']['store']['lockmanager_b'] = "localhost"  ## set to secondary lock manager lock2 below
default['atg']['store']['lock_port_b'] = "9010"
default['atg']['store']['use_lock'] = "true"

## standalone lock managers. Make sure store locks point correctly.
default['atg']['lock1']['lockmanager'] = "192.168.10"
default['atg']['lock1']['lock_port'] = "9010"
default['atg']['lock2']['lockmanager'] = "192.168.20"
default['atg']['lock2']['lock_port'] = "9011"

default['atg']['ca']['lockmanager'] = "localhost"
default['atg']['ca']['lock_port'] = "9011"
default['atg']['ca']['use_lock'] = "true"

default['atg']['staging']['lockmanager'] = "localhost"
default['atg']['staging']['lock_port'] = "9012"
default['atg']['staging']['use_lock'] = "true"

default['atg']['workflow_manager'] = "localhost:8851"  ## Should be hostname of ca server
default['atg']['pes'] = "localhost:8550"  ## Process editor server
default['atg']['ges'] = "localhost:8550"  ## Global editor server
default['atg']['ism'] = "localhost:8551" ## Individual scenario manager server - points to bcc

## Lockmanager configs for cluster
default['atg']['otherServerPollInterval'] = 2000
default['atg']['waitTimeBeforeSwitchingFromBackup'] = 10000

################
## Jboss Configurations
################
default['atg']['transaction_timeout'] = 2500  ## This configures the database transaction timeout on the store agents when running bcc deployments

# Logging priority for log4j within jboss.
default['atg']['log_priority'] = "INFO"

################
## Instance specific Configurations if more than one instance is installed on a machine.
## YOU SHOULD NOT NEED TO MODIFY ANYTHING BELOW.
###############
# Port Configurations for instance A
default['atg']['a']['port_preset'] = "default"
default['atg']['a']['http_port'] = 8080
default['atg']['a']['https_port'] = 8443
default['atg']['a']['drp_port'] = 8850
default['atg']['a']['file_deploy_port'] = 8810
default['atg']['a']['rmi_port'] = 8860
default['atg']['a']['lockmng_port'] = 9010
default['atg']['a']['jmx_remote'] = 25350 ## Should change this one for security - but keep unique

# Port Configurations for instance B
default['atg']['b']['port_preset'] = "01"
default['atg']['b']['http_port'] = 8180
default['atg']['b']['https_port'] = 8543
default['atg']['b']['drp_port'] = 8851
default['atg']['b']['file_deploy_port'] = 8811
default['atg']['b']['rmi_port'] = 8861
default['atg']['b']['lockmng_port'] = 9011
default['atg']['b']['jmx_remote'] = 25351 ## Should change this one for security - but keep unique

# Port Configurations for instance C
default['atg']['c']['port_preset'] = "02"
default['atg']['c']['http_port'] = 8280
default['atg']['c']['https_port'] = 8643
default['atg']['c']['drp_port'] = 8852
default['atg']['c']['file_deploy_port'] = 8812
default['atg']['c']['rmi_port'] = 8862
default['atg']['c']['lockmng_port'] = 9012
default['atg']['c']['jmx_remote'] = 25352 ## Should change this one for security - but keep unique

# Port Configurations for instance D
default['atg']['d']['port_preset'] = "03"
default['atg']['d']['http_port'] = 8380
default['atg']['d']['https_port'] = 8743
default['atg']['d']['drp_port'] = 8853
default['atg']['d']['file_deploy_port'] = 8813
default['atg']['d']['rmi_port'] = 8863
default['atg']['d']['lockmng_port'] = 9013
default['atg']['d']['jmx_remote'] = 25353 ## Should change this one for security - but keep unique
