version = node[:liverebel][:version]
path = node[:liverebel][:path]

file_to_fetch = "http://headless.zeroturnaround.org/download.php?file=liverebel-#{version}.zip&robot=chef"

execute "fetch #{file_to_fetch}" do
  cwd "/tmp"
  command "wget -O liverebel-#{version}.zip \"#{file_to_fetch}\""
  not_if { FileTest.exists?("/tmp/liverebel-#{version}") }
end

package "unzip" do
      action :install
end

execute "rm -r /tmp/liverebel" do
  cwd "/tmp"
  command "rm -r /tmp/liverebel"
  only_if { FileTest.directory?("/tmp/liverebel") }
end

execute "unzip /tmp/liverebel-#{version}.zip" do
  cwd "/tmp"
  command "unzip /tmp/liverebel-#{version}.zip"
  not_if { FileTest.directory?("/tmp/liverebel-#{version}.zip") }
end

execute "mv /tmp/liverebel" do
  cwd "/tmp"
  command "mv /tmp/liverebel /opt/liverebel-#{version}"
  not_if { FileTest.directory?("/opt/liverebel-#{version}") }
end
