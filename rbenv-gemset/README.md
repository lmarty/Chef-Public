# rbenv-gemset cookbook

Installs and manages rbenv-gemsets in order to provide gemset support to rbenv

* [rbenv](https://github.com/sstephenson/rbenv)
* [rbenv-gemset](https://github.com/jamis/rbenv-gemset)

# Requirements

* Chef 10
* Centos / Redhat / Fedora / Ubuntu / Debian
* Git

# Attributes

`node[:rbenv_gemset][:git_repository]` - Repository from where we should clone our code for rbenv-gemset
`node[:rbenv_gemset][:git_revision]` - Branch that we should take the code from

# Usage

Include recipe[rbenv-gemset] in your run_list.

# Authors and Contributors

* José P. Airosa (<me@joseairosa.com>)