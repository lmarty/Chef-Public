## Addolux LLC Configuration for JBOSS attributes

default['jboss']['jboss_root'] = "/usr/local/jboss"
default['jboss']['version'] = "jboss-eap-5.1"
default['jboss']['binary_file'] = "#{node.jboss.version}-20111115.tgz"
default['jboss']['dl_url'] = "http://www.URLtoStorage.com/files/"
default['jboss']['jboss_user'] = "jboss"
default['jboss']['java_home'] = "/usr/lib/jvm/java/jdk1.6.0_24"
default['jboss']['jboss_home'] = "#{node.jboss.jboss_root}/jboss-as"  ## removed version here - clean later
default['jboss']['cleanup'] = "no"  ## If you upgrade jboss you will need to clean up old installation.
default['jboss']['old_version'] = "jboss-eap-5.0"  ## Provide old version name to be removed.  Also you may consider leaving old version if you have a need to revert.
default['jboss']['old_binary'] = "#{node.jboss.old_version}-2010.tgz"
default['jboss']['cglib_jar'] = "cglib.jar"  ## provide name of cglib.jar in remote storage. This is needed because the default cglib does not work well with atg.
## http://repository.jboss.org/cglib/2.2-brew/lib/cglib.jar