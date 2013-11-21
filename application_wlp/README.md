# Description


The __application_wlp__ cookbook deploys applications to the WebSphere Application Server Liberty Profile.

Note that this cookbook provides the Liberty Profile specific bindings for the application cookbook; you will find general documentation in that cookbook.

# Requirements

## Platform:

* Debian
* Ubuntu
* Centos
* Redhat

## Cookbooks:

* application (~> 3.0)
* wlp

# Resources

The LWRPs provided by this cookbook are not meant to be used by themselves; make sure you are familiar with the application cookbook before proceeding.

* [wlp_application](#wlp_application)

## wlp_application


### Attribute Parameters

- server_name: 
- features:  Defaults to <code>[]</code>.
- application_location: 
- config: 
- server_config:  Defaults to <code>{"httpEndpoint"=>{"id"=>"defaultHttpEndpoint", "host"=>"*", "httpPort"=>"9080", "httpsPort"=>"9443"}}</code>.

# Usage

Deploy an application to Liberty:

    application "my-app" do
      path "/usr/local/my-app"
      repository "/nas/distro/my-app.war"
      revision "..."
			scm_provider Chef::Provider::File::Deploy

      wlp_application do
          server_name "MyAppServer"
          features [ "jsp-2.2", "servlet-3.0" ]
      end
    end

If you need to provide custom application configuration you can provide your own server.xml configuration:
 
    application "my-app" do
      path "/usr/local/my-app"
      repository "/nas/distro/my-app.war"
      revision "..."
			scm_provider Chef::Provider::File::Deploy

      wlp_application do
          server_name "MyAppServer"
          config ({
            "featureManager" => { 
              "feature" => ["jsp-2.2" ] },
            "application" => {
              "name" => "myApp",
              "location" => "/usr/local/my-app/current/my-app.war" }
          })
      end
    end

# Support

Use the [issue tracker][] for reporting any bugs or enhancements. For any questions please use the [WASdev forum](https://www.ibm.com/developerworks/community/forums/html/forum?id=11111111-0000-0000-0000-000000002666).

[issue tracker]: https://github.com/WASdev/ci.chef.wlp/issues

The cookbook is maintained by IBM.

# Notice

© Copyright IBM Corporation 2013.

# License

```text
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
