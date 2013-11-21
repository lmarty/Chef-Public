easy-iptables Cookbook
======================
Installs and configures iptables.

Requirements
------------
Platform:

* CentOS
* RHEL

Attributes
----------

#### easy-iptables::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['easy-iptables']['tables']</tt></td>
    <td>Array</td>
    <td>iptables configurations</td>
    <td><tt><pre>
[
  {
    "name" => "filter",
    "policies" => [
      ":INPUT ACCEPT [0:0]",
      ":FORWARD ACCEPT [0:0]",
      ":OUTPUT ACCEPT [0:0]"
    ],
    "rules" => [
      "-A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT",
      "-A INPUT -p icmp -j ACCEPT",
      "-A INPUT -i lo -j ACCEPT",
      "-A INPUT -m state --state NEW -m tcp -p tcp --dport 22 -j ACCEPT",
      "-A INPUT -j REJECT --reject-with icmp-host-prohibited",
      "-A FORWARD -j REJECT --reject-with icmp-host-prohibited"
    ]
  }
]
    </pre></tt></td>
  </tr>
</table>

Usage
-----
#### easy-iptables::default
Set node['easy-iptables']['tables'] attributes and
include `easy-iptables` in your node's `run_list`:

```json
{
  "easy-iptables": {
    "tables": [
      {
        "name": "filter",
        "policies": [
          ":INPUT ACCEPT [0:0]",
          ":FORWARD ACCEPT [0:0]",
          ":OUTPUT ACCEPT [0:0]"
        ],
        "rules": [
          "-A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT",
          "-A INPUT -p icmp -j ACCEPT",
          "-A INPUT -i lo -j ACCEPT",
          "-A INPUT -m state --state NEW -m tcp -p tcp --dport 22 -j ACCEPT",
          "-A INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT",
          "-A INPUT -m state --state NEW -m tcp -p tcp --dport 443 -j ACCEPT",
          "-A INPUT -j REJECT --reject-with icmp-host-prohibited",
          "-A FORWARD -j REJECT --reject-with icmp-host-prohibited"
        ]
      }
    ]
  },
  "run_list": [
    "recipe[easy-iptables]"
  ]
}
```

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Author: Hiroaki Nakamura
