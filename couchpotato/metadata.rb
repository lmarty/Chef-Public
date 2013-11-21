maintainer       "Alex Howells"
maintainer_email "alex@howells.me"
license          "Apache 2.0"
description      "Installs and configures CouchPotato onto a node"
version          "0.0.1"
 
%w{ ubuntu }.each do |os|
  supports os
end
