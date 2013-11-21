def load_current_resource
  @login       = new_resource.login
  @full_name   = new_resource.full_name || @login
  @email       = new_resource.email || "#{@login}@#{node['fqdn']}"
  @home        = new_resource.home  || (@login == 'root' ? '/root' : "/home/#{@login}")
  @private_key = new_resource.private_key
  @known_hosts = new_resource.known_hosts
end

action :create do
  # scope variables
  home, login = @home, @login
  private_key, known_hosts = @private_key, @known_hosts

  key_r = nil
  ssh_r = nil

  if private_key
    identity_file = "#{home}/.ssh/git_user_rsa"

    key_r = file identity_file do
      content private_key
      mode '0600'
      owner login
    end

    if known_hosts.empty?
      Chef::Log.warn("known_hosts not provided for #{login}, #{identity_file} won't take effect!")
    else
      ssh_r = template "#{home}/.ssh/config" do
        cookbook 'git_user'
        source 'ssh_config.erb'
        owner login
        variables(
          :known_hosts => known_hosts,
          :identity_file => identity_file
        )
      end

      known_hosts.each do |host|
        ssh_known_hosts_entry host
      end
    end
  end

  conf_r = gitconfig(@home, @full_name, @email)

  [ conf_r, key_r, ssh_r ].each do |res|
    if res && res.updated_by_last_action?
      new_resource.updated_by_last_action(true)
      break
    end
  end

end

def gitconfig(home, full_name, email)
  template "#{home}/.gitconfig" do
    cookbook 'git_user'
    source 'gitconfig.erb'
    mode '0644'

    variables(
      :name  => full_name,
      :email => email
    )
  end
end
