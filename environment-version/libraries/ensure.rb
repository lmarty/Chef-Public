
class Chef
  class Recipe
    
    # Checks version information provided in the current
    # envs is a hash 
    #   key: environment name
    #   val:  
    def environment_version_ensure(envs)
      
      envs = envs.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
        
      required_version = envs[node.chef_environment.to_sym]
      found_version = node[:environment_version]
      
      Chef::Log.debug "Using chef environment '#{node.chef_environment}', version #{found_version} (requires #{required_version})"
        
      if !required_version.nil? 
        if found_version.nil?
          Chef::Application::fatal!("This cookbook requires this environment to contain a version attribute. To do this, add a default attribute 'environment_version' to your environment.")
        elsif found_version < required_version
          Chef::Application::fatal!("This cookbook requires '#{node.chef_environment}' environment version #{required_version} or greater, you're using version #{found_version}")
        end
      end
    end
  end
end

