Travis-ci status: [![Build Status](https://secure.travis-ci.org/jackl0phty/opschef-cookbook-unix-shells.png?branch=master)](http://travis-ci.org/jackl0phty/opschef-cookbook-unix-shells)


Description
===========

A cookbook that can install multiple UNIX shells.

Supported Platforms
===================

* Debian & derivatives.
* Redhat & derivatives. ( Note: Not all shells supported )

Supported SHELLS
================

* __CSH__ - A shell with C-like syntax on Debian & derivatives.
* __BASH__ - The GNU Bourne Again SHell.
* __TCSH__ - The TENEX C Shell, an enhanced version of Berkeley csh.
* __KORN__ - A shell Written by David Korn, while at Bell Labs.
* __PDKSH__ - A Public domain version of the Korn shel. Requires attribute override.
* __MKSH__ - The MirBSD Korn Shell. Requires attribute override.

Attributes
==========

* __attributes/korn.rb__ - Korn shell related attributes.

<pre><code>
Install public domain Korn shell
Set attribute ['unix_shells']['install_pdksh'] to 'yes'.

Install MirBSD Korn Shell
Set attribute ['unix_shells']['install_mksh'] to 'yes'.
</pre></code>

Usage
=====

* __BASH__ - Apply recipe unix_shells::bash to your node to install the BASH shell.

* __CSH__ - Apply recipe unix_shells::csh to your node to install the CSH shell.

* __RC__ - Apply recipe unix_shells::rc to your node to install the RC shell.

* __SCSH__ - Apply recipe unix_shells::scsh to your node to install the SCSH shell.

* __TCSH__ - Apply recipe unix_shells::tcsh to your node to install the TCSH shell.

* __ZSH__ - Apply recipe unix_shells::zsh to your node to install the ZSH shell.

* __KORN__ - Apply recipe unix_shells::korn to your node to install the KORN shell.

* __PDKSH__ - Apply recipe unix_shells::korn AND set/override attribute ['unix_shells']['install_pdksh'] to yes.

* __MKSH__ - Apply recipe unix_shells::korn AND set/override attribute ['unix_shells']['install_mksh'] to yes.
