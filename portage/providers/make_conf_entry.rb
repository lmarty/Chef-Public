include Chef::Portage::Helper

def load_current_resource
  @config = '/etc/portage/make.conf'
end

action(:replace) do
  replace_or_insert("#{new_resource.entry}=\"#{new_resource.value}\"")
end

action(:remove) { remove }
