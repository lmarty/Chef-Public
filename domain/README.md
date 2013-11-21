Domain Cookbook
======================
Enables management of membership to an Active Directory domain through an LWRP.

Requirements
------------
This cookbook currently applies only to the Windows platform.

Usage
-----
#### domain::member

Include `domain_member` resource in your recipe and provide a value for the
`'domain'` attribute, along with credentials valid in the domain for joining a
system via the domain_user and domain_password attributes.

```
domain_member do
  domain 'mydomain.myorg.org'
  domain_user 'myuser'
  domain_password 'mypass'
  organizational_unit 'OU=mycomputers,DC=mydomain,DC=myorg,DC=org' # optional
end
```

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------

|                      |                                          |
|:---------------------|:-----------------------------------------|
| **Author:**          | Adam Edwards
| **Copyright:**       | Copyright (c) 2013 Adam Edwards
| **License:**         | Apache License, Version 2.0

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

