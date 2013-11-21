#
# Cookbook Name:: repos
# Recipe:: jenkins-debian-glue
#

case node['platform']
when "debian","ubuntu"
  apt_repository "jenkins-debian-glue" do
    uri "http://jenkins.grml.org/debian"
    distribution "jenkins-debian-glue-release"
    components ["main"]
    key "http://jenkins.grml.org/debian/C525F56752D4A654.asc"
    deb_src true
  end
end
