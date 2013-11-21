getaddrinfo Cookbook
====================
Configures getaddrinfo.

Usage
-----
#### LWRPs

This cookbook provides LWRPs to manage `/etc/gai.conf`.

```ruby
getaddrinfo_label "Mega label" do
  mask "fc00::/7"
  value 6
end
```

```ruby
getaddrinfo_precedence "We prefer IPv4" do
  mask "::ffff:0:0/96"
  value 100
end
```

```ruby
getaddrinfo_scope "Scoped" do
  mask "::ffff:0.0.0.0/96"
  value 14
end
```

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github
