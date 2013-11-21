#
# Cookbook Name:: linux-dev-env
# Recipe:: java 
#
# Copyright 2012, Gerald L. Hevener Jr., M.S.
#

# Install Sun Java6 JDK on x86_64 arch
if node['target_cpu'] = "x86_64"

  script "install Java 6 JDK" do

    interpreter "bash"
    user "root"
    cwd "/tmp"
    code <<-EOH
    mkdir -p /usr/local/bin/java/64
    cd /usr/local/bin/java/64
    wget --no-cookies --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com" "http://download.oracle.com/otn-pub/java/jdk/#{node['linux-dev-env']['java_version']}-b06/jdk-#{node['linux-dev-env']['java_version']}-linux-x64.bin"
    chmod u+x jdk-#{node['linux-dev-env']['java_version']}-linux-x64.bin
    ./jdk-#{node['linux-dev-env']['java_version']}-linux-x64.bin
    EOH
    not_if "test -f /usr/local/bin/java/64/jdk-#{node['linux-dev-env']['java_version']}-linux-x64.bin"
    not_if "ls -al /usr/local/bin/java/64/ |grep jdk1"
  end
 
# Create symbolic link
  script "set-sun-java-as-default" do

  interpreter "bash"
    user "root"
    cwd "/tmp"
    code <<-EOH
    ln -s /usr/local/bin/java/64/jdk1.6.0_37 /usr/local/bin/oracle-java-default
    update-alternatives --install "/usr/bin/java" "java" "/usr/local/bin/oracle-java-default/bin/java" 1
    update-alternatives --set java "/usr/local/bin/oracle-java-default/bin/java"
    EOH
    not_if "test -L /usr/local/bin/oracle-java-default"
    not_if "update-alternatives --get-selections |grep java |grep manual |grep /usr/local/bin/oracle-java-default/bin/java"
  end

end 
