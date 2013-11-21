rubygems-compatibility
===============================

Chef's interactions with Rubygems (i.e. chef_gem) depends on the internals of Rubygems,
which changed in version 2 of the API.

This has been fixed in chef master and is targeted for release in 11.6. Until then, this
cookbook brings in the new code to fix compatibility in order versions of the client.

## Usage

Add the `rubygems-compatibility::default` recipe to a node's run list.

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

## License and Authors

Authors:
* Eric Saxby
