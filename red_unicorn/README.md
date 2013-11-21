RedUnicorn
==========

This cookbook installs the red_unicorn gem and provides an easy to use
LWRP for configuring a unicorn application with bluepill monitoring.

Usage
=====

```ruby
red_unicorn_config 'my_application' do
  preload_app node[:app][:preload]
  worker_processes node[:app][:workers]
  start_grace_time node[:bluepill][:start_grace_time]
  stop_grace_time node[:bluepill][:stop_grace_time]
  restart_grace_time node[:bluepill][:restart_grace_time]
  max_memory_usage_mb node[:bluepill][:mem_usage_mb]
  max_cpu_usage_percent node[:bluepill][:cpu_usage_percent] 
end
```

Cookbook Dependencies
=====================

* Bluepill

Notes
-----

This version only provides bluepill based support. Other setup options on the way.

Info
====

Repository: https://github.com/hw-cookbooks/red_unicorn
IRC: #heavywater @ Freenode

red_unicorn: https://github.com/chrisroberts/red_unicorn
