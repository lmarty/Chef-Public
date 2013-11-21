Description
===========

[![Build Status](https://secure.travis-ci.org/realityforge/chef-bonita.png?branch=master)](http://travis-ci.org/realityforge/chef-bonita)

Download BonitaSoft from a remote location and install it into the tomcat directories according to the directions. The
cookbook has been tested with the "Subscription Pack" version of the Bonita product.

This cookbook now uses packages that were generated from the "glassfish-bonita":https://github.com/realityforge/glassfish-bonita
project. That project generates several jars that feed into this cookbook.

Unfortunately the install can not be completely automated as BonitaSoft requires that you generate a license for the
specific host that the product is deployed upon. So after the initial install you need to generate a license key as per
the directions given by BonitaSoft (i.e. Run either /usr/local/bonita-x.x.x/licenses/generateRequestForAnyEnvironment.sh
or /usr/local/bonita-x.x.x/licenses/generateRequestForDevelopmentEnvironment.sh and send of request to bonita and wait
for a response). The license needs to be made available over http. We make this license also available in a local Maven
 repository.

The cookbook has only been tested when deploying to MS SQL server but it is expected that modifying the configuration
settings will make the cookbook work with other database vendors.

Attributes
==========

* `node['bonita']['packages']['bonita']` - The url to bonita war file. Must be specified.
* `node['bonita']['packages']['xcmis']` - The url to xcmis war file. Must be specified.
* `node['bonita']['packages']['keygen']` - The url to jar for creating license requests. Must be specified.
* `node['bonita']['packages']['client']` - The url to zip containing client tempaltes used on server. Must be specified.
* `node['bonita']['license']['url']` - The url to the license file for the bonita software.
* `node['bonita']['license']['type']` - The type of license to generate request for. Should be 'development' or 'production'.
* `node['bonita']['license']['request']` - The request string generated for this node. It is synthesized by the recipe.
* `node['bonita']['logging_properties']` - A map of properties merged into the logging configuration.
* `node['bonita']['database']['hibernate']['dialect']` - = 'org.hibernate.dialect.SQLServerDialect'.
* `node['bonita']['database']['exo_jcr']['dialect']` - The xCMIS jcr dialect. Defaults to 'mssql'.
* `node['bonita']['database']['hibernate']['interceptor']` - The Bonita hibernate interceptor. Defaults to 'org.ow2.bonita.env.interceptor.MSSQLServerDescNullsFirstInterceptor'.
* `node['bonita']['database']['jdbc']['driver']` - The class name of the database driver. Defaults to 'net.sourceforge.jtds.jdbc.Driver'.
* `node['bonita']['database']['jdbc']['history']['url']` - The database jdbc url for bonita history database. Must be specified.
* `node['bonita']['database']['jdbc']['history']['schema']` - The database schema for the bonita history database. May be specified.
* `node['bonita']['database']['jdbc']['journal']['url']` - The database jdbc url for bonita journal database. Must be specified.
* `node['bonita']['database']['jdbc']['journal']['schema']` - The database schema for the bonita journal database. May be specified.
* `node['bonita']['database']['jdbc']['xcmis']['url']` - The database jdbc url for xcmis. Must be specified.
* `node['bonita']['database']['jdbc']['username']` - The database username.
* `node['bonita']['database']['jdbc']['password']` - The database username.
* `node['bonita']['xcmis']['username']` - The xCMIS username.
* `node['bonita']['xcmis']['password']` - The xCMIS password.

Usage
=====

Here is some example properties defined on a role that includes bonita.

    :bonita =>
      {
        :packages {
         'bonita' => 'http://repo.example.com/bonita-5.x.war',
         'xcmis' => 'http://repo.example.com/xcmis-5.x.war',
         'keygen' => 'http://repo.example.com/keygen-5.x.jar',
         'client' => 'http://repo.example.com/client-5.x.jar',
        }
        :license => {:url => 'http://repo.example.com/com/bonitasoft/bonitasoft-server-sp/license/5.6/license-5.6-MyUser-bonita.example.com-20111128-20120226.lic'},
        :extra_libraries => ['http://repo.example.com/net/sourceforge/jtds/jtds/1.2.4/jtds-1.2.4.jar'],
        :database =>
          {
            :jdbc =>
              {
                :journal => {:url => 'jdbc:jtds:sqlserver://db.example.com/BONITA', :schema => 'journal'},
                :history => {:url => 'jdbc:jtds:sqlserver://db.example.com/BONITA', :schema => 'history'},
                :xcmis => {:url => 'jdbc:jtds:sqlserver://db.example.com/xCMIS'},
                :username => 'username',
                :password => 'password',
              }
          },
      :xcmis =>
        {
          :username => 'xcmis_username',
          :password => 'xcmis_password'
        }
      }
