name             "xpdf"
maintainer       "Phil Cohen"
maintainer_email "github@phlippers.net"
license          "MIT"
description      "xpdf - Portable Document Format (PDF) suite"
long_description IO.read(File.join(File.dirname(__FILE__), "README.md"))
version          "1.0.0"

recipe "xpdf",         "Default recipe for installing xpdf utilities"
recipe "xpdf::common", "common files"
recipe "xpdf::reader", "viewer for X11"
recipe "xpdf::utils",  "utilities"

supports "ubuntu"
