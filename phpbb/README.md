# chef-phpbb cookbook

This cookbook provides an LWRP to setup PhpBB app

# Requirements

# Usage

Add `phpbb` as dependency in your cookbook's metadata file.

    depends 'phpbb'

Now you can use the following LWRP in your cookbook's recipe.

    phpbb_instance "phpbb1" do
      doc_root "/var/www/phpbb-app"
      db_name "phpbb_db"
      db_user "phpbb_user"
      db_password "phpbb_passwd"
      domain "phpbb.local"
    end

Then navigate to `your-domain.com/install`

# Attributes

# Recipes

# Author

Author:: Millisami (<millisami@gmail.com>)
