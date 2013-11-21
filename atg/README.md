Description
===========
ATG Cookbook provides best practices for efficient ATG configuration management of Oracle's ATG Web Commerce core platform. It will handle servers with single to multiple JBoss instances and provides flexibility to determine where you will setup your lock management, global, process and workflow managers. It will also handle port configurations up to 4 instances per jboss server or node.

This cook book does not install ATG itself or any components nor does it deploy the ears.

Included in this cookbook is support for ATG 10.0.x on JBoss 5.1 EAP (10.1 requires slight modifications to accommodate some of the configuration changes in that version)

For more information about atg cookbook please see http://addolux.com/index.php/services/atg-cookbook

Requirements
============
* generic-users and sudo cookbooks.
* Jboss-atg cookbook which is a customized version of the jboss cookbook originally written by by Bryan W. Berry. Customizations were necessary to to accommodate this ATG cookbook. You also need your own file storage to store JBoss 5.1 eap - preferably a slimmed down version.
* JAVA cookbook by Seth Chisamore and Bryan Berry

Attributes
==========
Please see attributes file. This file will need to be configured before running.

Usage
=====
To use this cookbook. Go through the atg/attributes/default.rb for proper settings for your environment.
Apply atg instance information to your nodes such as store-a, ca-b and stage-c.

    "atg": {
      "instances": [
        "store-a",
        "ca-b",
        "staging-c"
      ]
    }
    
The dash letter is called 'slots' and are used to define 1st, 2nd, 3rd and 4th instances (d is maximum). They will configure the ports for those instances based on the letter you provide.
You cannot use for example:

    "atg": {
      "instances": [
        "store-a",
        "store-a",  
        "ca-b",
        "staging-a"
      ]
    }
    
This will cause your application server to fail due to port conflicts. So its important while you can have multiple stores, you must have unique slot letters.
This would be correct method for the above:

    "atg": {
      "instances": [
        "store-a",
        "store-b",  
        "ca-c",
        "staging-d"
      ]
    }

You can even do (skipping a letter):

    "atg": {
      "instances": [
        "store-a",
        "staging-d"
      ]
    }
    
    
LICENSE AND AUTHOR
==================

Author:: John Kip Larsen <john.larsen@addolux.com>

Copyright 2010-2012, Addolux LLC

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

