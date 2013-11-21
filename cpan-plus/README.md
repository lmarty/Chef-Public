# Description
wrapper for cpanplus installer

# Requirements
CPANPLUS. run cpan-plus::bootstrap to satisfy

# Attributes

## default attributes:

- `cpan_plus.deps` - list of dependencies (see cpan-plus::bootstrap)

- `cpan_plus.mirrors` - cpan mirrors list 

# Definitions
- `cpan_plus`

## Definition's parameters
- `action` :configure|:set_custom_sources|:reload_index|:install
- `user`
- `group`
- `home`
- `local_lib` - Array
- `custom_sources` - Array
- `environment` - Hash

# Usage

    cpan_plus "configure cpanplus" do
        action :configure
        user 'melezhik'
        group 'users'
        home '/home/melezhik/'
    end

    cpan_plus "setup custom sources" do
        action :set_custom_sources
        user 'melezhik'
        group 'users'
        home '/home/melezhik/'
        local_lib ['/usr/local/rle', '/home/melezhik/cpanlib' ]
        custom_sources ['http://localhost/cpan-plus-cs/']
    end

    cpan_plus "install Moose" do
        action :install
        user 'melezhik'
        group 'users'
        home '/home/melezhik/'
        local_lib ['/usr/local/perllib', '/home/melezhik/cpanlib' ]
        module_name 'Moose'
    end



