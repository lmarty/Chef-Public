name             "gkrellmd"
maintainer       "Chris"
maintainer_email "chris@locomote.com"
license          "BSD"
description      "Installs and configures the gkrellm daemon"
version          "0.3.2"

%w{redhat centos ubuntu debian}.each do |os|
  supports os
end

depends "yum"
