if(RUBY_VERSION < '1.9.0')
  if(self.respond_to?(:chef_gem))
    chef_gem 'orderedhash'
  else
    pkg = gem_package 'orderedhash' do
      action :nothing
    end
    pkg.run_action(:install)
    Gem.clear_paths
  end
  require 'orderedhash'
end
