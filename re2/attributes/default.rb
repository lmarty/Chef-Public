
#default['re2']['version'] = "1.7.0"

case node[:platform]
  when "fedora"
    default[:re2][:install_method] = "package"
    default[:re2][:packages] = %w(re2 re2-devel)
  else
    default[:re2][:install_method] = "repository"
    default[:re2][:repository] = "https://re2.googlecode.com/hg"
    #check if this file exists, otherwise install
    default[:re][:installed_lib] = "/usr/local/lib/libre2.so.0.0.0"
end
