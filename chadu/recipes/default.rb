#
# Cookbook Name:: chadu
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

open("/var/log/chadu.log", "a") do |f|
    f.puts "user: '#{node['chadu']['usern']}' tries to install chadu on \""+Time.new.strftime("%a, %b %d %Y -%I:%M:%S %p %Z")+" (GMT +05:30)\""
end

if ::File.exists?('/usr/bin/chadu')
    first_run = 'no'

    open("/var/log/chadu.log", "a") do |f|
        f.puts "'chadu' installation skipped... it's already installed!\n\n"
        f.puts "-----\n\n"
    end
else
    first_run = 'yes'

    open("/var/log/chadu.log", "a") do |f|
        f.puts "'chadu' installation begins..."
    end
end

if first_run == 'yes'
    execute "chadu-download" do
        command "wget -O /usr/bin/chadu https://raw.github.com/jophinep/chadu/master/chadu"
        ignore_failure true
    end

    execute "chadu-mod" do
        command "chmod +rx /usr/bin/chadu"
        ignore_failure true
    end

    execute "chadu-alias" do
        command "cd && echo 'alias chadu=\". chadu\"' >> ~/.bashrc"
        ignore_failure true
    end

    execute "chadu-source" do
        command "source ~/.bashrc"
        ignore_failure true
    end

    open("/var/log/chadu.log", "a") do |f|
        f.puts "'chadu' installation completed on \""+Time.new.strftime("%a, %b %d %Y -%I:%M:%S %p %Z")+" (GMT +05:30)\"\n\n"
        f.puts "-----\n\n"
    end
end
