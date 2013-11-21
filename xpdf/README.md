# DESCRIPTION

Installs [Xpdf](http://www.foolabs.com/xpdf/). Xpdf is an open source viewer for Portable Document Format (PDF) files. (These are also sometimes also called 'Acrobat' files, from the name of Adobe's PDF software.) The Xpdf project also includes a PDF text extractor, PDF-to-PostScript converter, and various other utilities.


# REQUIREMENTS

## Supported Platforms

The following platforms are supported by this cookbook, meaning that the recipes run on these platforms without error:

* Ubuntu

# RECIPES

* `xpdf`,         Default recipe for installing xpdf utilities
* `xpdf::common`, common files
* `xpdf::reader`, viewer for X11
* `xpdf::utils`,  utilities


# USAGE

This cookbook installs the xpdf components if not present, and pulls updates if they are installed on the system.

# ATTRIBUTES

None


## Basic Settings

None


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


## License

**chef-xpdf**

* Freely distributable and licensed under the [MIT license](http://phlipper.mit-license.org/2012/license.html).
* Copyright (c) 2012 Phil Cohen (github@phlippers.net) [![endorse](http://api.coderwall.com/phlipper/endorsecount.png)](http://coderwall.com/phlipper)
* http://phlippers.net/
