# Description

Sets up sparkleshare dashboard (https://github.com/NewProggie/SparkleShare-Android/wiki/Testing-SparkleShare-for-Android)

Dashboard has the advanced capability to sync with mobile devices.

Currently Dashboard is tested in connection with GitLab. (TODO insert link to gitlab cookbook)

Currently only one repository (main sync repository) is supported.

# Requirements
```
openssh
```

# Attributes
Target repository
```ruby
default['sparkleshare']['repo_dir'] = "/home/storage"
default['sparkleshare']['repo_name'] = "SparkleShare"
```
Directory for source code of dashboard
```ruby
default['sparkleshare']['dashboard_dir'] = "/home/storage/dashboard"
```
Session secret for client/server communication
```ruby
default['sparkleshare']['session_secret'] = 'JustSomeRandomString'
```

# Usage
- Set up ```node['sparkleshare']['session_secret']```
- Run recipe ```sparkleshare::dashboard```

# Ideas/Todo
- Finish and test the server cookbook
- use LWRP to share repositories 

```ruby
sparkleshare_repository "myCoolRepo" do
  visibility "private" #"public"
  path "/path/to/git/repo" #defaults to node attr
end
```

# Contact
see metadata.rb

