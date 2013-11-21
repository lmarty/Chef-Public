checksum Cookbook
==========================

Silly little utility cookbook for simple checksum operations

Usage
===============

Pretty simple

```ruby
checksum_file "file path to checksum" do
  checksum "checksum to compare with"
end
```
