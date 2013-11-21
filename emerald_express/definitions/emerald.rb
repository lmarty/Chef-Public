define :emerald, base_path: nil, gemfile: 'Gemfile', user: nil, group: nil do
  base_path = params[:base_path]

  directory base_path do
    user params[:user]
    group params[:group]
  end

  params[:files].concat([params[:gemfile]])

  params[:files].each do |filepath|
    cookbook_file "#{base_path}/#{File.basename(filepath)}" do
      source filepath
      user params[:user]
      group params[:group]
      backup false
    end
  end

  params[:commands].merge!(
    init: 'export GEM_HOME=vendor/bundle/ruby/1.9.1',
    build: ['rm -rf .bundle', 'bundle package && bundle install --deployment --binstubs']
  )

  params[:commands].each do |key, value|
    template 'command' do
      path "#{base_path}/#{key}"
      mode "0755"
      user params[:user]
      group params[:group]
      backup false
      variables({
        commands: Array.try_convert(value) || [value],
        script_name: key
      })
    end
  end

  execute "./build" do
    cwd base_path
  end
end
