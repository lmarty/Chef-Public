Description
===========
This cookbook is designed to install the gow application on a windows machine.
Gow is an application that gives unix type commands to the windows command
line.

Requirements
============
This needs windows cookbooks.

Attributes
==========
default["gow"]["url"] = "https://github.com/downloads/bmatzelle/gow/Gow-0.5.0.exe"

Usage
=====

This works out of the box. All you need to do is add this recipe to the
servers run list.
