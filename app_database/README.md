# app_database cookbook

Cookbook for Opscode Chef.

http://community.opscode.com/cookbooks/app_database


# Description

Provides new resources/providers for managing application databases.

Features include **migrations**, **automatic backup**s, and easier **command-line access**.

Currently supported databases include: **MySQL** (more coming, and contributions welcome)

This cookbook is part of a larger application management cookbook suite we'll be releasing in the near future.
It is meant to be simple/concise, and then consumed by larger more complex cookbooks.

Migrations are primarily intended for initial provisioning, but can be used for updates if you increment the `:schema_version` attribute.  **There is no automatic rollback from schema update failures however.**

For those database types that require authentication it is expected that the username/password and target database already exist. **It is not recommended to use these resources under a database super-admin account.**

# Usage / Result

Given this sample resource declaration:

    app_database "my_app" do
      action [ :configure, :backup, :migrate ]
      basepath "/tmp/app_database_test/mysql_test"  # required
      owner "nobody"                                # required
      uri "mysql://localhost/test"                  # required
      username "test_user"                          # optional
      password "test_pass"                          # optional
      schema_version "1.0"                          # optional
    end

And a template file: `templates/default/migrate/mysql.erb`

    -- THIS FILE IS ONLY REQUIRED FOR THE `:migrate` ACTION

    <% if "#{@current_version}".empty? -%>
      --
      -- First migration only.
      --
      CREATE TABLE app_database_test(counter int);
      INSERT INTO app_database_test (counter) VALUES (0);
    <% end -%>

    <% v1 = Gem::Version.new(1.0)
       if @current_version < v1 && @new_version >= v1 -%>
      --
      -- Upgrade/Migrate up to version 1.0
      --
      UPDATE app_database_test SET counter=counter+1;
    <% end -%>

**Then the following files would be created during the Chef run:**

`%{basepath}/mysql.conf`

    [client]
    host=localhost
    port=3306
    user=test_user
    pass=test_pass
    database=test

`%{basepath}/backup-my_app-20130101.mysql.tgz`

File would be a compressed tarball of the mysqldump for the database on the given date.
Backup will only be attempted if the `:backup` action is used, and if there is not an existing backup for the day.

In this case the compressed sql file would be similar to:

    --
    -- Table structure for table `app_database_test`
    --

    DROP TABLE IF EXISTS `app_database_test`;
    CREATE TABLE `app_database_test` (
      `counter` int(11) DEFAULT NULL
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8;

    --
    -- Dumping data for table `app_database_test`
    --

    LOCK TABLES `app_database_test` WRITE;
    INSERT INTO `app_database_test` VALUES (1);
    UNLOCK TABLES;


# Recipes

This cookbook only provides resources/providers, no recipes are included.


# Test-Kitchen

This package is **test-kitchen** enabled and automatically tested against:

- CentOS
- Ubuntu

A successful test appears as follows:

    -----> Running bats test suite
           1..3
           ok 1 :configure
           ok 2 :migrate
           ok 3 :backup
           Finished verifying (0m1.81s).


# Development and Maintenance

* Found a bug?
* Need some help?
* Have a suggestion?
* Want to contribute?

Please visit: [code.binbab.org](http://code.binbab.org)


# Authors and License

  * Author:: BinaryBabel OSS (<projects@binarybabel.org>)
  * Copyright:: 2013 `sha1(OWNER) = df334a7237f10846a0ca302bd323e35ee1463931`
  * License:: Apache License, Version 2.0

----

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
