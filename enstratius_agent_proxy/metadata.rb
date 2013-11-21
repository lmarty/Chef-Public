name             "enstratius_agent_proxy"
maintainer       "Enstratius"
maintainer_email "support@enstratius.com"
license          "All rights reserved"
description      "Installs/Configures enstratius-agent-proxy"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0"
%w{java runit apt yum sudo}.each do |cb|
  depends cb
end

supports "debian"
supports "ubuntu"
