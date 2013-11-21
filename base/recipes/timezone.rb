
file "/etc/timezone" do
  content node[:timezone]
end

execute "update timezone" do
  command "dpkg-reconfigure -f noninteractive tzdata"
end
