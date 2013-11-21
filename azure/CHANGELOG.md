## 0.2.0:

* Made the OHAI plugin installation optional
* Changed the name of the OHAI plugin to azure_custom.rb
* Enabled cleanup of older plugin revisions

## 0.1.2:

* Added resource disk information

## 0.1.1:

* Added platform check
* Converted some directives from execute phase to compile phase
* Added instance code detection
* Updated OHAI plugin to detect newer A6/A7 instances
* We now support custom DNS
* Completely reload OHAI upon Azure plugin loading in order to allow other plugins
  that depend on attributes like `cloud hostname` to be notified of the update

## 0.1.0:

* Initial release
