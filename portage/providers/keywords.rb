include Chef::Portage::Helper

def load_current_resource
  @config = '/etc/portage/package.keywords'
end

action(:add)    { add    }
action(:remove) { remove }

