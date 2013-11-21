def load_current_resource
    @app = Chef::Resource::WebApplication.new(new_resource.name)
    @app.name(new_resource.name)
    @app.user(new_resource.user)
    @app.group(new_resource.group)
    @app.url(new_resource.url)
    @app.base(new_resource.base || "/home/#{@app.user}" )
    @app.pattern(new_resource.pattern)
    @app.override(new_resource.override)
    nil
end


action :dump_resource do
    validate_resource_attributes!
    Chef::Log.info "name:#{@app.name}"
    Chef::Log.info "url:#{@app.url}"
    Chef::Log.info "user:#{@app.user}"
    Chef::Log.info "group:#{@app.group}"
    Chef::Log.info "base:#{@app.base}"
    Chef::Log.info "pattern:#{@app.pattern}"
    Chef::Log.info "override:#{@app.override}"
    new_resource.updated_by_last_action true    
end

action :fetch do
    validate_resource_attributes!
    fetch
    new_resource.updated_by_last_action true    
end


action :unpack do
    validate_resource_attributes!
    unpack
    new_resource.updated_by_last_action true    
end

action :symlink do
    validate_resource_attributes!
    symlink
    new_resource.updated_by_last_action true    
end

action :deliver do
    validate_resource_attributes!
    fetch
    unpack
    symlink
    new_resource.updated_by_last_action true    
end

action :clean do
    validate_resource_attributes!
    cleanup
    new_resource.updated_by_last_action true    
end

action :delete do
    validate_resource_attributes!
    delete_application
    new_resource.updated_by_last_action true    
end

def cleanup 

     if ( @app.pattern.nil? || @app.pattern.empty? )
        raise "pattern attribute is required"
     end

    user_name = @app.user
    group_name = @app.group
    pattern = @app.pattern

    log "doing cleanup ..."
    Dir["#{apps_dir}/#{pattern}"].map {|d| "#{::File.dirname(d)}/#{::File.basename(d)}" }.select {|d| ::File.directory? d and ! ::File.symlink? d }.reject { |d| ::File.basename(::File.readlink(apps_home)) == ::File.basename(d) }.each do |d|
      directory d do
        recursive true
        owner user_name
        group group_name
        action :delete
      end
    end

end

def delete_application 

    user_name = @app.user
    group_name = @app.group

	directory ::File.readlink(apps_home) do
		recursive true
		owner user_name
		group group_name
		action :delete
	end

end

def symlink 
    user_name = @app.user
    group_name = @app.group
    link apps_home do
        owner user_name
        group group_name
        to apps_home_with_version
    end
end

def unpack
    user_name = @app.user
    group_name = @app.group

    if @app.override == true
        directory apps_home_with_version do
            user user_name
            group group_name
            recursive true
            action :delete 
        end
    end

    execute "tar -zxf #{distributive_file}" do
         user user_name
         group group_name
         cwd apps_dir
         not_if {::File.exists?(apps_home_with_version)} 
    end
end

def fetch 

    url = @app.url
    user_name = @app.user
    group_name = @app.group

    directory apps_dir do
        owner user_name
        group group_name
    end

    remote_file "#{apps_dir}/#{distributive_file}" do
        source url
        owner user_name
        group group_name
        mode "0644"
    end
end


def validate_resource_attributes!

 if ( @app.name.nil? ||@app.name.empty? )
    raise "name attribute is required"
 end

 if ( @app.user.nil? ||@app.user.empty? )
    raise "user attribute is required"
 end

 if ( @app.group.nil? ||@app.group.to_s.empty? )
    raise "group attribute is required"
 end


 #if ( @app.url.nil? ||@app.url.empty? )
 #   raise "url attribute is required"
 #end
  
end


def apps_dir
    "#{@app.base}/apps"
end

def apps_home 
    "#{apps_dir}/#{@app.name}"
end

def distributive_file
    file = @app.url.split('/' ).last
end

def apps_home_with_version
   "#{apps_dir}/#{distributive_file.sub /\.tar\.gz$/, ''}"
end

