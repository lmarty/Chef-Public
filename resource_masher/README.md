# Resource Masher - Chef Cookbook

This cookbook provides a library which extends Chef Resource objects with new abilities to export their attribute
values, including default values, and with the added functionality of a Mash wrapper.

There are no sepcial requirements, it extends all resources generically.

# Overview

## Limitations of Chef default functionality

By default Chef provides a `.to_hash` method on Resources, which exports a Hash of its attributes; but
its implimentation is counter-intuitive.

If an LWRP supplies default values, and they are not overwritten, those keys/values are not included in Chef's
`.to_hash` export. By design the Hash behaves more like a serialization.

# Usage

This cookbook adds the methods `.attribute_mash` and `.attribute_mash_formatted` to Chef resources.

The following example illustrates its usage in an LWRP provider. **Please note:**

  * You do not need to be within a provider to invoke these functions.
  * Only your cookbook needs to depend on the **resource_masher**, target resources require no modifications.

## LWRP Example

Given the following sample LWRP resource describing a plugin:

    actions :install, :remove
    default_action :install

    attribute :plugin_name, :name_attribute => true
    attribute :vendor, :required => true
    attribute :branch, :default => 'stable'
    attribute :install_path, :default => '/opt/%{vendor}/%{plugin_name}'


And the following invocation from a recipie:

    my_plugin_lwrp "sample_plugin" do
      action :install
      vendor "doe.corp"
    end


Let's look at how the **resource_masher** helps in the provider:

    action :install do

       #
       # Let's export the new_resource a few different ways.
       # Perhaps for use with a Template's variables.
       #

       # Export to Hash using Chef's default method.
       exp_chef     = new_resource.to_hash

       # Export to Mash using 'attribute_mash'.
       exp_mash     = new_resource.attribute_mash

       # Export to Mash using 'attribute_mash_formatted'.
       exp_mash_fmt = new_resource.attribute_mash_formatted

       # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

       # PROBLEM: Chef's Hash is incomplete.
       #
       # exp_chef is equal {
       #   :plugin_name => "sample_plugin",
       #   :vendor => "doe.corp"
       # }
       #
       # !!! It's missing :branch and :install_path, which were defaults. !!!

       # INCONVENIENCE: Chef's Hash is just a Hash
       #
       # You can only do this:
       #   exp_chef[:plugin_name]
       #
       # Not:
       #   exp_chef["plugin_name"]
       #   exp_chef.plugin_name

       # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

       # SOLUTION Part-1: Complete output (optionally formatted)
       #
       # exp_mash is equal {
       #  :plugin_name => "sample_plugin",
       #  :vendor => "doe.corp",
       #  :branch => "stable",
       #  :install_path => "/opt/%{vendor}/%{plugin_name}"
       # }
       #
       # With the formatted version, the :install_path is different...
       #   exp_mash_fmt[:install_path] is equal "/opt/doe.corp/sample_plugin"
       #
       # !!! The string formatters were automatically back-filled !!!

       # SOLUTION Part-2: Our Mash, is a Mash, of course, of course
       #
       # You can do all of these now:
       #   exp_mash[:plugin_name]
       #   exp_mash["plugin_name"]
       #   exp_mash.plugin_name
       #   exp_mash.symbolize_keys  # returns normal (complete) Hash

    end

## Formatting

The `.attribute_mash_formatted` method replaces any tokens in String values with matching values defined on the
resource.

From the above example:

`:install_path => "/opt/%{vendor}/%{plugin_name}"` becomes `/opt/doe.corp/sample_plugin`

When using the formatting feature, please note the following:

  * The tokens use **percent signs**, not hash-marks.
    This is standard Ruby syntax for such operations. [See here for more info](http://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Literals#The_.25_Notation)
  * If the replacement requires recursion, there is a depth limit of **three(3)** to safe-guard infinate loops.
  * An undefined token will generate an exception, but you can supply extra data to avoid this.

You can supply additional data to inject with the formatting. This data acts as additional defaults,
any matching attributes on the resource itself will override the provided data.

    extra_data = { :alpha => 'AAA', :beta => 'BBB' }
    export = new_resource.attribute_mash_formatted(extra_data)

## Validation

The ResourceMash returned has an added `.validate` method which incorporates the standard Chef validation tools
for ease of use. Additionally the values returned from the validation replace any existing values in the Mash
(if different) ... permitting the use of the :default validation option as well.

An ideal use case is when generic super-class resources are distilled into more specific sub-classes. Such as how
the stock 'remote_file' resource is an extension of the 'file' resource. The ResourceMash validation method can be a
quick way to transform/validate the resource data as needed.

For more information on the validation syntax, [see the Chef docs linked here](http://docs.opscode.com/lwrp_custom_resource.html).

Example usage:

    export = new_resource.attribute_mash
    export.validate({
      :alpha   => { :equal_to => 'AAA' },
      :beta    => { :kind_of => String },
      :charlie => { :default => 'CCC' }
    })


# Bugs / Docs / Updates

Please see: [code.binbab.org](http://code.binbab.org)


# Versioning

The cookbook uses semantic versioning. Releases will be numbered in the following format:

`<major>.<minor>.<patch>`

And constructed with the following guidelines:

* Breaking backward compatibility bumps the major (and resets the minor and patch)
* New additions without breaking backward compatibility bumps the minor (and resets the patch)
* Bug fixes and misc changes bumps the patch

For more information on SemVer, visit http://semver.org/.

# Authors and License

  * Author:: BinaryBabel OSS (<projects@binarybabel.org>)
  * Copyright:: 2013 `sha1(OWNER) = df334a7237f10846a0ca302bd323e35ee1463931`
  * License:: Apache License, Version 2.0

----

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
