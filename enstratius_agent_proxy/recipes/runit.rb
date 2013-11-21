runit_service "enstratius-agent-proxy" do
  action [:enable,:start]
  subscribes :restart , "template[#{node['enstratius_agent_proxy']['installdir']}/agentproxy.properties]"
end
