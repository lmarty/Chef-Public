## v5.7.1:

* Refactor the cookbook to use the artifacts produced by the glassfish-bonita project @
  https://github.com/realityforge/glassfish-bonita
* Generate a license request and save it as attribute data at bonita.license.request
* Update the base directory attribute to allow it to be reconfigured.

## v0.1.3:

* Use create_if_missing when downloading resources.
* Remove additional files from install directory that are not needed at runtime.

## v0.1.2:

* Include the `tomcat::default` recipe at the top of the `bonita::default` recipe to simplify deployment.
* Support the configuration of the logging properties.

## v0.1.1:

* Upgrade to version 5.7.1 of BonitaSoft product.
* Rename the attributes used to define the bonita database urls and support configuration of database schemas.
* Replace the usage of the `node['bonita']['database']['driver_package_url']` attribute with the
  `node['bonita']['extra_libraries']` attributes that contains a list of jars to add to classpath.
* Ensure compliance with foodcritic recommendations and enforce via TravisCI.
* Remove the default usernames and passwords for all the database connections. Add guards in recipe to ensure they
  are specified.
* Remove the requirement for setting the checksum for packages as guards where already in place.
* Force the overriding of the tomcat attributes for bonita rather than setting normal attributes if not already
  specified.

## v0.1.0:

* Initial release