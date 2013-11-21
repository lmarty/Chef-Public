
if node[:hostname]

  file "/etc/hostname" do
    content "#{node[:host]}\n"
    mode "0644"
  end

  if node[:hostname] != node[:host]
    execute "hostname #{node[:host]}"
  end

end
