Description
===========

Thruk is a multibackend monitoring web interface which currently
supports Nagios, Icinga and Shinken as backend using the Livestatus
API. It is designed to be a drop in replacement and covers almost all
of the original features plus adds additional enhancements for large
installations.

See http://www.thruk.org/ for more information.

Requirements
============

#### cookbooks
- `apache2`

Attributes
==========

Usage
=====
#### thruk::default
Use the recipe directly, or include it in a role to customize it:

    % cat roles/thruk.rb
    name "thruk"
    run_list( "recipe[thruk]" )
    override_attributes(
      "thruk" => {
        "use_ssl" => true,
        "htpasswd" => "/etc/shinken/htpasswd.users",
        "cert_name" => "_.example.com",
        "cert_ca_name" => "gd_bundle",
        "start_page" => "/thruk/cgi-bin/tac.cgi",
        "first_day_of_week" => 0,
        "backends" => {
          "shinken" => {
            "name" => "External Shinken",
            "type" => "livestatus",
            "options" => {
              "peer" => "127.0.0.01 =>50000",
            },
          },
        },
        "cmd_defaults" => {
          "ahas" => 1,
          "force_check" => 1,
          "persistent_ack" => 1,
        },
     },
   )

Contributing
============

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
===================
Authors: Martha Greenberg
