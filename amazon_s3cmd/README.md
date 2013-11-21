Travis-ci status: [![Build Status](https://secure.travis-ci.org/jackl0phty/opschef-cookbook-amazon_s3cmd.png?branch=master)](http://travis-ci.org/jackl0phty/opschef-cookbook-amazon_s3cmd)

amazon_s3cmd Cookbook
=====================

This cookbook will install s3tools which gives you access to the s3cmd command which you can use to 
transfer files to/from Amazon's Simple Storage Service S3.

Requirements
------------

#### packages
- Debian: python-magic, s3cmd.
- Redhat: s3cmd.
- Arch: s3cmd.
- Gentoo: s3cmd.
- SUSE: There is no s3cmd package.

Attributes
----------

# User using s3cmd.
<pre><code>
node.set['amazon_s3cmd']['user'] = 'root'
</pre></code>

# Group using s3cmd.
<pre><code>
node.set['amazon_s3cmd']['group'] = 'root'
</pre></code>

# Location of s3cmd config.
<pre><code>
node.set['amazon_s3cmd']['s3cfg'] = "#{node['amazon_s3cmd']['user']}/.s3cfg"
</pre></code>
# Amazon S3 Key. No need to override.
# Will be populated from encrypted data bag you created. 
# See USAGE section of this README for details.
<pre><code>
node.set['amazon_s3cmd']['amazon_key'] = ''
</pre></code>
# Amazon secret. No need to override.
# Will be populated from encrypted data bag you created. 
# See USAGE section of this README for details.
<pre><code>
node.set['amazon_s3cmd']['amazon_secret'] = ''
</pre></code>

# Encrypted data bag secret file.
<pre><code>
node.set['amazon_s3cmd']['data_bag_secret'] = '/etc/chef/encrypted_data_bag_secret'
</pre></code>

# Encrypted data bag name.
<pre><code>
node.set['amazonZ_s3cmd']['encrypted_data_bag_name'] = 's3cmd'
</pre></code>

# Encrypted data bag item.
<pre><code>
node.set['amazonZ_s3cmd']['encrypted_data_bag_item'] = 's3cfg'
</pre></code>

Usage
-----

# You'll need to create a secret key for your data bag.
<pre><code>
skywalker@alderaan:~$ openssl rand -base64 512 > data_bag_secret_key
</pre></code>
# Create new data bag item to be used with S3.
<pre><code>
skywalker@alderaan:~/your/chef-repo$ knife data bag create  --secret-file ~/data_bag_secret_key s3cmd s3cfg 
Created data_bag[s3cmd] 
Created data_bag_item[s3cfg] 

{ 
  "id": "s3cfg", 
  "s3_access_key": "YOUR_S3_ACCESS_KEY_HERE", 
  "s3_secret_key": "YOUR_S3_SECRET_KEY_HERE" 
} 
</pre></code>

# If you get the following error below...
<pre><code>
ERROR: RuntimeError: Please set EDITOR environment variable
</pre></code>

# ...make sure you export your editor as EDITOR
<pre><code>
export EDITOR=vim
</pre></code>

# Verify your encrypted data bag items.
<pre><code>
skywaler@alderaan:~/your/chef-repo$ knife data bag show s3cmd s3cfg 
id:            s3cfg 
s3_access_key: 
  cipher:         aes-256-cbc 
  encrypted_data:  BUNCH_OF_RANDOM_CHARS_HERE
  
  iv:             RANDOM_CHARS_HERE
  
  version:        1 
s3_secret_key: 
  cipher:         aes-256-cbc 
  encrypted_data: BUNCH_OF_RANDOM_CHARS_HERE
  
  iv:             RANDOM_CHARS_HERE
  
  version:        1 
skywaler@alderaan:~/your/chef-repo$ 
</pre></code>

# Now check your decrypted data bag items
<pre><code>
skywaler@alderaan:~/your/chef-repo$ knife data bag show –secret-file=/home/you/data_bag_secret_key s3cmd s3cfg 
id:            s3cfg 
s3_access_key: YOUR_ACCESS_KEY_HERE
s3_secret_key: YOUR_SECRET_KEY_HERE
</pre></code>

# Copy your secret key to your node.
<pre><code>
skywalker@alderaan:~ $ scp -P 6565 /home/you/data_bag_secret_key skywalker@alderaan: 
skywalker@alderaan's password: 
data_bag_secret_key                                                                                                                                                            100%  695     0.7KB/s   00:00    
</pre></code>

# Move your key to /etc/chef
<pre><code>
skywalker@alderaan:~ $ sudo mv /home/skywalker/data_bag_secret_key /etc/chef/
</pre></code>

Just include `amazon_s3cmd` in your node's `run_list`:

<pre><code>
{
  "name":"my_node",
  "run_list": [
    "recipe[amazon_s3cmd]"
  ]
}
</pre></code>

Future TODO list.
-----------------

1. Add an amazon_s3cmd::source recipe to install latest via source.
2. Add some Chefspec tests.

Contributing
------------
1. Fork the repository on Github by clicking [here](https://github.com/jackl0phty/opschef-cookbook-amazon_s3cmd/fork).
2. Create a topic branch (like `yourname-add-awesomeness`).
3. Write you change.
4. Write tests for your change (if applicable).
5. Run the tests, ensuring they all pass.
6. Submit a Pull Request using Github [here](https://github.com/jackl0phty/opschef-cookbook-amazon_s3cmd).

License and Authors
-------------------
Licensed under the Apache 2.0 "The License".
For questions regarding the license of this software please see the actual license located [here](http://www.apache.org/licenses/LICENSE-2.0)
Gerald L. Hevener Jr., Jackl0phty LLC.
