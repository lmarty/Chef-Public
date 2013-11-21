# rbenv-bootstrap cookbook

Installs/Configures rbenv-bootstrap which will install ruby shims during chef provision

* [rbenv](https://github.com/sstephenson/rbenv)

# Requirements

* Chef 10
* Centos / Redhat / Fedora / Ubuntu / Debian

# Attributes

`node[:rbenv_bootstrap][:install_versions]` - Array of versions to be installed

# Usage

Include recipe[rbenv-bootstrap] in your run_list and configure `node[:rbenv_bootstrap][:install_versions]` with correct
list of ruby versions to be installed.

# Authors and Contributors

* José P. Airosa (<me@joseairosa.com>)