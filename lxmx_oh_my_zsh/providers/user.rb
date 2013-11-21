def load_current_resource
  @login = new_resource.login

  unless @home = new_resource.home
    @home = @login == 'root' ? '/root' : "/home/#{@login}"
  end
end

action :ensure do
  if ::File.exists?("#{@home}/.oh-my-zsh") && ::File.exists?("#{@home}/.zshrc")
    Chef::Log.info("#{@home}/.oh-my-zsh exists and action is :ensure, skipping")
  else
    install
  end
end

action :update do
  install
end

def install
  login, home = @login, @home

  arch_r = ark ".oh-my-zsh" do
    path home
    url 'https://github.com/robbyrussell/oh-my-zsh/archive/master.tar.gz'
    action :put
  end

  conf_r = template "#{home}/.zshrc" do
    cookbook 'lxmx_oh_my_zsh'
    source 'zshrc.erb'
    owner login
    mode '644'
    variables({
      :theme          => new_resource.theme,
      :case_sensitive => new_resource.case_sensitive,
      :plugins        => new_resource.plugins,
      :autocorrect    => new_resource.autocorrect
    })
  end

  updated = conf_r.updated_by_last_action? || arch_r.updated_by_last_action?
  new_resource.updated_by_last_action(updated)
end
