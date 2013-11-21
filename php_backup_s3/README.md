# phpBackupS3 cookbook

This cookbook assists with the usage and deployment of [phpBackupS3](https://github.com/ianneub/php_backup_s3).

You can view the source code, get help, and contribute to this cookbook on [GitHub](https://github.com/ianneub/php_backup_s3-cookbook).

# Requirements

* You must have PHP installed on the system. On Ubuntu you can do that with this command:

    `sudo apt-get install php5-cli php5-mysql php5-curl`

* You must also have `git` installed on your system. On Ubuntu you can do that with this command:

    `sudo apt-get install git`

# Usage

Place the `php_backup_s3::default` cookbook in your run_list. This will install `php_backup_s3` on your node and setup the cron job to run the backups.

Once the `php_backup_s3::default` cookbook as been run, you will need to call either or both of the LWRPs in order to actually back up files and/or databases, as follows:

    php_backup_s3 "etc" do
  
      backup_files %w(/etc /root)

      databases = []
      databases << {
        "hostname" => "host",
        "username" => "user",
        "password" => "pass",
        "password" => "pass",
        "query" => "SELECT * WHERE 1 = 1"
      }
      backup_dbs databases
    
    end

Please see the recipes/test.rb file for an example.

# Attributes

## Required

* `node["php_backup_s3"]["s3_bucket"]` - This is the s3 bucket that you want to backup to.
* `node["php_backup_s3"]["aws_access_key"]` - You must supply your AWS access key.
* `node["php_backup_s3"]["aws_secret_key"]` - You must supply your AWS secret key.

## Defaults

* `node["php_backup_s3"]["frequency"]` - This will set how often your backup will run. Can be set to one of: weekly, daily, hourly. Default is "daily".
* `node["php_backup_s3"]["cron"]["minute"]` - Set the minute that the backup will run. The default is "0".
* `node["php_backup_s3"]["cron"]["hour"]` - Set the hour that the backup will run. The default is "0".
* `node["php_backup_s3"]["cron"]["weekday"]` - Set the weekday that the backup will run. The default is "0" or Sunday.

# Recipes

There are no external recipe dependencies.

# Author

Author:: Ian Neubert (ian@ianneubert.com)
