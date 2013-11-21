# Cookbook Name:: application_wlp
# Attributes:: default
#
# (C) Copyright IBM Corporation 2013.
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

require "rexml/document"

module Liberty
  module Applications
    class Config
    
      attr_accessor :doc
      attr_accessor :modified

      def initialize(utils, serverName, doc)
        @utils = utils
        @serverName = serverName
        @doc = doc
        @modified = false
      end

      def self.load(node, serverName)
        utils = Liberty::Utils.new(node)
        applicationsXml = "#{utils.serversDirectory}/#{serverName}/server.xml"
        f = File.open(applicationsXml)
        doc = REXML::Document.new(f)
        f.close
        return Config.new(utils, serverName, doc)
      end
      
      def save()
        applicationsXmlNew = "#{@utils.serversDirectory}/#{@serverName}/server.xml.new"
        out = File.open(applicationsXmlNew, "w")
        formatter = REXML::Formatters::Pretty.new
        formatter.compact = true
        formatter.write(@doc, out)
        out.close
        
        @utils.chown(applicationsXmlNew)

        applicationsXml = "#{@utils.serversDirectory}/#{@serverName}/server.xml"
        FileUtils.mv(applicationsXmlNew, applicationsXml)
      end
      
      def include(location)
        return Include.new(self, location)
      end
      
    end
    
    class Include
      
      def initialize(parent, location)
        @parent = parent
        
        @include = @parent.doc.root.elements["include[@location='#{location}']"]
        if ! @include 
          @include = REXML::Element.new("include")
          @include.attributes["location"] = location
          @parent.doc.root << @include
          @parent.modified = true
        end
        
      end
      
    end
    
  end
end
