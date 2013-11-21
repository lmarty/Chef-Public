include_recipe 'apt'

unless(node[:pkg_build][:builder])
  apt_node = discovery_search(
    'builder:true',
    :environment_aware => node[:pkg_build][:common_repo_env],
    :empty_ok => true,
    :remove_self => true,
    :minimum_response_time_sec => false,
    :raw_search => true
  )
end

# TODO: Add proper SSL once repository has added it
# TODO: Customize what components and distributions we use here
if(apt_node)
  apt_url = "http://#{apt_node[:repository][:frontend][:fqdn]}:#{apt_node[:repository][:frontend][:listen_port]}"
  apt_repository 'pkg_build_repository' do
    uri apt_url
    distribution node[:pkg_build][:add_repo][:distribution]
    components node[:pkg_build][:add_repo][:components]
    key ::File.join(apt_url, "#{apt_node[:gpg][:name][:email]}.gpg.key")
    action :add
  end
else
  Chef::Log.warn 'Failed to locate pkg-build node. No apt repository added!'
end
