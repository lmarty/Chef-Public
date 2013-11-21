# portage

## Usage

Use `portage_mask`, `portage_use` and `portage_keywords` resources to add or remove package flags or settings.

## Requirements

### Platform

This cookbook is intended for Gentoo Linux but should also work on Gentoo derivatives such as Funtoo and Calculate.
Please [raise an issue](https://github.com/lxmx-cookbooks/portage/issues) if it doesn't work on your platform.

## Resources and Providers


### use, keywords, mask

This resource allows you to add or remove `/etc/portage/package.*` entries.


#### Actions

<table>
  <thead>
    <tr>
      <th>Action</th>
      <th>Description</th>
      <th>Default</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>add</td>
      <td>Adds an entry</td>
      <td>Yes</td>
     </tr>
    <tr>
      <td>remove</td>
      <td>Removes an entry</td>
      <td></td>
    </tr>
  </tbody>
</table>

#### Attributes

<table>
  <thead>
    <tr>
      <th>Attribute</th>
      <th>Description</th>
      <th>Default Value</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>entry</td>
      <td>
        <b>Name attribute:</b> an entry to add or remove e.g.
        <code>"=x11-libs/cairo-1.10.2-r3 X"</code>
      </td>
      <td><code>nil</code></td>
    </tr>
  </tbody>
</table>

#### Examples

```
portage_use "sys-kernel/genkernel -cryptsetup"
```

```
portage_mask ">=net-libs/nodejs-0.9.0" do
  action :remove
end
```

```
portage_keywords "dev-db/mysql ~amd64"
```

### make_conf_entry

This resource allows you to add, replace and delete `/etc/portage/make.conf` entries.

#### Actions

<table>
  <thead>
    <tr>
      <th>Action</th>
      <th>Description</th>
      <th>Default</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>replace</td>
      <td>Adds or replaces an entry</td>
      <td>Yes</td>
     </tr>
    <tr>
      <td>remove</td>
      <td>Removes an entry</td>
      <td></td>
    </tr>
  </tbody>
</table>

#### Attributes

<table>
  <thead>
    <tr>
      <th>Attribute</th>
      <th>Description</th>
      <th>Default Value</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>entry</td>
      <td>
        <b>Name attribute:</b> a variable name to add/replace or remove e.g.
        <code>"FEATURES"</code>
      </td>
      <td><code>nil</code></td>
    </tr>
    <tr>
      <td>value</td>
      <td>
        Variable value (if you're adding/replacing one), e.g.
        <code>'${FEATURES} parallel-fetch getbinpkg'</code>
      </td>
      <td><code>nil</code></td>
    </tr>
  </tbody>
</table>


#### Examples

```
portage_make_conf_entry "FEATURES" do
  value '${FEATURES} parallel-fetch getbinpkg'
end
```

```
portage_make_conf_entry "PORTAGE_BINHOST" do
  action :remove
end
```

## License

Copyright:: Vasily Mikhaylichenko and LxMx.

Licensed under BSD license.

    http://opensource.org/licenses/BSD-2-Clause
