# chef-incron

Installs the incron package and starts the incrond service.

## About incron

Incron is an "inotify cron" system. It consists of a daemon and a table manipulator. You can use it a similar way as the regular cron. The difference is that the inotify cron handles filesystem events rather than time periods.

[More information about incron](http://inotify.aiken.cz/?section=incron&page=about&lang=en)

## Recipes

### `default`

This will install the incron package and start the service.

## Resources

### `incron_d`

This resource helps you create a system incron table.

```ruby
incron_d "notify_home_changes" do
  path "/home"
  mask "IN_MODIFY"
  command "/usr/local/bin/abcd"
end
```

[More information about syntax](http://linux.die.net/man/5/incrontab)

## License and Author

License: [MIT](https://github.com/dwradcliffe/chef-incron/blob/master/LICENSE)

Author: [David Radcliffe](https://github.com/dwradcliffe)

