#!/bin/bash

#Ugly shell script to create and load all data_bags 

knife data bag create initials
knife data bag from file initials initial1.json

knife data bag create fcuplinkports
knife data bag from file fcuplinkports FIA.json
knife data bag from file fcuplinkports FIB.json

knife data bag create hostfirmwares
knife data bag from file hostfirmwares adaptor.json
knife data bag from file hostfirmwares bios.json
knife data bag from file hostfirmwares controller.json
knife data bag from file hostfirmwares fcadaptor.json
knife data bag from file hostfirmwares hbaoptionrom.json

knife data bag create managers
knife data bag from file managers sp1.json

knife data bag create mgmtfirmwares
knife data bag from file mgmtfirmwares mgmt1.json

knife data bag create networks
knife data bag from file networks vlan100.json
knife data bag from file networks vlan200.json

knife data bag create networktemplates
knife data bag from file networktemplates template1.json
knife data bag from file networktemplates template2.json

knife data bag create orgs
knife data bag from file orgs hr.json
knife data bag from file orgs it.json

knife data bag create policies
knife data bag from file policies policy1.json

knife data bag create pools
knife data bag from file pools pool1.json

knife data bag create portchannels
knife data bag from file portchannels FIA.json
knife data bag from file portchannels FIB.json

knife data bag create serverports
knife data bag from file serverports FIA.json
knife data bag from file serverports FIB.json

knife data bag create serviceprofiles
knife data bag from file serviceprofiles sppack1.json

knife data bag create serviceprofiletemplates
knife data bag from file serviceprofiletemplates template1.json

knife data bag create storage
knife data bag from file storage vsan100.json
knife data bag from file storage vsan200.json

knife data bag create storagetemplates
knife data bag from file storagetemplates template1.json
knife data bag from file storagetemplates template2.json

knife data bag create uplinkports
knife data bag from file uplinkports FIA.json
knife data bag from file uplinkports FIB.json




