#!/usr/bin/ruby
#
# Cookbook Name:: cerberus
# Library:: advfirewall
#
# Author:: Steven Craig <support@smashrun.com>
# Copyright 2013, Smashrun, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# order of the arguments of the set and add commands is important:
# http://technet.microsoft.com/en-us/library/dd736066(v=ws.10).aspx
#

['pp','pathname','ipaddr','rubygems','json'].each do |g|
  begin
    require "#{g}"
  rescue LoadError
    puts "Missing #{g}"
  end
end

class Advfirewall

  attr_accessor :debug, :md5

  def initialize(jsonpath)

    @jsonpath = Pathname.new(jsonpath)
    @json = ""
    @jsoncfg = ""
    @fwcommand = ""
    
    if File.exist?(@jsonpath)
      #puts "Found #{@jsonpath}"
      @json = File.read(@jsonpath)
      @jsoncfg = JSON.parse(@json)
      #print @jsoncfg.class.to_s + " "
      #puts @jsoncfg.inspect
      #puts @jsoncfg['id']

      # need to build the commands from the json files
      # first, sanitize the "description" field
      # this might be a little aggressive
      if @jsoncfg['description'] =~ /[~!$%^&*|<>?=]*/
        @jsoncfg['description'].gsub!(/[~!$%^&*|<>?=]/,'_')
      end

      # if description contains whitespace, ensure that description is enclosed in quotes
      if @jsoncfg['description'] =~ / /
        unless @jsoncfg['description'] =~ /^\"/
          @jsoncfg['description'] = "\"" + @jsoncfg['description']
        end
        unless @jsoncfg['description'] =~ /\"$/
          @jsoncfg['description'] = @jsoncfg['description'] + "\""
        end
      end

      # if netmask is blank
      # perhaps there is a comma delineated list of addresses and netmasks inside the "ipaddress" field
      # check to see if ipaddress contains at least one slash
      # if it does, assume there is a valid netmask
      # check to see if it validates as an ipv4 address... if so, process it
      # if not, error with message
      ipaddress = ""
      if @jsoncfg['netmask'] == ""
        checkip = @jsoncfg['ipaddress'].split(',')
        checkip.each do |ip|
          unless ip =~ /\//
            abort("Error in #{@jsoncfg['name']} ipaddress #{ip}! If multiple ipaddresses are specified, each ipaddress string must contain a netmask suffix in \'/32\', \'/27\', etc, format!")
          end
          verify = IPAddr.new(ip)
          unless verify.ipv4?
            abort("#{@jsoncfg['name']} ipaddress string portion #{verify} does not validate as ipv4 address!")
          end
        end
        ipaddress = @jsoncfg['ipaddress']
      else
        # be kind - if @jsoncfg['netmask'] is not prefixed with a slash, add one
        unless @jsoncfg['netmask'] =~ /^\//
          @jsoncfg['netmask'].gsub!(/^/,'/')
        end
        ipaddress = @jsoncfg['ipaddress'] + @jsoncfg['netmask']
        verify = IPAddr.new(ipaddress)
        unless verify.ipv4?
          abort("#{@jsoncfg['name']} ipaddress string portion #{verify} does not validate as ipv4 address!")
        end
      end

      setcmdprefix = 'netsh advfirewall firewall set rule name='
      addcmdprefix = 'netsh advfirewall firewall add rule name='
      cmdsuffix = '>NUL'
      #cmdsuffix = ''

      # first, check "protocol"
      # if icmp, it is special... do it first

      if @jsoncfg['protocol'] =~ /icmp/
        setcmd = setcmdprefix + @jsoncfg['name'] + ' profile=any new enable=yes dir=in action=allow description=' + @jsoncfg['description'] + ' remoteip=' + ipaddress + ' protocol=' + @jsoncfg['protocol'] + ' localip=any' + cmdsuffix
        addcmd = addcmdprefix + @jsoncfg['name'] + ' profile=any enable=yes dir=in action=allow description=' + @jsoncfg['description'] + ' remoteip=' + ipaddress + ' protocol=' + @jsoncfg['protocol'] + ' localip=any' + cmdsuffix
      
      # else, it should be standard type rule
      else
        setcmd = setcmdprefix + @jsoncfg['name'] + ' profile=any new enable=yes dir=in action=allow description=' + @jsoncfg['description'] + ' remoteip=' + ipaddress + ' localport=' + @jsoncfg['id'] + ' protocol=' + @jsoncfg['protocol'] + ' localip=any' + cmdsuffix
        addcmd = addcmdprefix + @jsoncfg['name'] + ' profile=any enable=yes dir=in action=allow description=' + @jsoncfg['description'] + ' remoteip=' + ipaddress + ' localport=' + @jsoncfg['id'] + ' protocol=' + @jsoncfg['protocol'] + ' localip=any' + cmdsuffix
      end

      # just run a "set" and test for the errorcode
      # if the errorcode is fail, run an "add"
      print "Checking to see if rule already exists... "
      setcmdreturn = system(setcmd)
      puts setcmdreturn.to_s.capitalize + "!"
      if setcmdreturn == false
        print "Rule does not exist, attempting to add new rule now... "
        addcmdreturn = system(addcmd)
        if addcmdreturn == true
          puts "New rule set!"
        else
          puts "Something horribly wrong happened!"
          puts "Attempted to use the following command: #{addcmd}"
        end
      else
        puts "Successfully updated existing rule!"
      end

    else
      puts "File not found! #{@jsonpath}"
    end

  end

  def debug
    puts "jsonfile path= " + self.jsonpath
    return true
  end

end
