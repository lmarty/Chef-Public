def load_current_resource
    @installer = Chef::Resource::JsApplication.new(new_resource.name)
    
    @installer.name(new_resource.name)
    @installer.user(new_resource.user)
    @installer.group(new_resource.group)
    @installer.tarball(new_resource.tarball)
    @installer.cookbook(new_resource.cookbook)

    @installer.install_base(new_resource.install_base)
    @installer.document_root(new_resource.document_root)

    @installer.install_version(new_resource.install_version)
    @installer.install_prefix(new_resource.install_prefix)

    @installer.dirs(new_resource.dirs)
    @installer.files(new_resource.files)

    @installer.templates(new_resource.templates)
    @installer.variables(new_resource.variables)
    
    @installer.local_source_dir(new_resource.local_source_dir)

    @installer.cleanup(new_resource.cleanup)
    
    @installer.make_access_rights(new_resource.make_access_rights)

    nil
end


action :install do

    user = @installer.user || ENV['USER']
    group = @installer.group
    tarball = @installer.tarball
    cookbook_name = @installer.cookbook

    install_base = @installer.install_base
    document_root = @installer.document_root

    install_version = @installer.install_version
    install_prefix = @installer.install_prefix

    dirs_list = @installer.dirs
    files_list = @installer.files
    local_source_dir = @installer.local_source_dir


    templates = @installer.templates
    js_variables_hash = @installer.variables

    cleanup = @installer.cleanup

    make_access_rights = @installer.make_access_rights
    
    cp_flags = '-fp'
    cp_flags << 'v' if @installer.verbose == true

    raise "document_root can't be nil neither empty" if ( document_root.nil? || document_root.empty?)
    
    if install_base.nil?
        Chef::Log.info "try to catching install_base via PERL_MB_OPT"
        raise "install_base not set; use eval $(perl -Mlocal::lib=install-base-path) to setup install base" unless ENV['PERL_MB_OPT']
        install_base = ENV['PERL_MB_OPT'].sub('--install_base ','')
    end

    Chef::Log.info "install_base: #{install_base}"
    Chef::Log.info "document_root: #{document_root}"
    Chef::Log.info "user: #{user}"
    Chef::Log.info "group: #{group}"

    if local_source_dir
        src_dir = local_source_dir
    else
        src_dir = '/tmp/chef-js-app/src'
        directory '/tmp/chef-js-app/' do
            owner user 
            group group
        end
        directory '/tmp/chef-js-app/src' do
            owner user 
            group group
        end
    end


    if cookbook_name
        Chef::Log.info "lookup files to be installed in cookbook"
        Chef::Log.info "cookbook parameter is set:#{cookbook_name}"

        directory "#{src_dir}/cookbook_name" do
            owner user
            group group
        end

        remote_directory "#{src_dir}/#{cookbook_name}/js-app" do
            cookbook cookbook_name
            files_owner  user
            files_group group
            mode '0755'
        end
        final_src_dir = "#{src_dir}/#{cookbook_name}/js-app" 
                
    elsif local_source_dir
        Chef::Log.info "lookup files to be installed in local src_dir:#{local_source_dir}"
        final_src_dir = src_dir
    else

        Chef::Log.info "lookup files to be installed in tarball"

        file_name = tarball.split('/').last
        distro_dir = file_name.sub('.tar.gz','')

        directory "#{src_dir}/#{distro_dir}" do
            owner user
            group group
            recursive true
            action :delete
        end

        Chef::Log.info "download remote file:#{tarball}"

        remote_file "#{src_dir}/#{file_name}" do
            source tarball
            owner user
            group group
            mode "0644"
        end
        
        file "#{src_dir}/tar.err" do 
            action :touch
            owner user
            group group
        end
        
        execute "tar -xzf #{file_name}" do
            user user
            group group
            command "tar -xzf #{file_name} 2>tar.err"
            cwd "#{src_dir}/"
        end

        Chef::Log.info "distro_dir: #{distro_dir}"
        final_src_dir = "#{src_dir}/#{distro_dir}"
    end


    Chef::Log.info "final source dir: #{final_src_dir}"

    if cleanup == true
        directory "#{install_base}/#{document_root}/" do
            recursive  true
            action :delete
        end
    end
    @installer.dirs.each do |d|

        check_source! d
        insert_vars_into_destination d
        
        target_dir = "#{install_base}/#{document_root}/"
        target_dir << d[:destination] if ( ! d[:destination].nil? and ! d[:destination].empty? )

        directory target_dir do
            recursive true
            owner user
            group group 
        end 

        execute "cp -r #{cp_flags} #{d[:source]}/* #{target_dir}" do
            user user
            group group
            cwd final_src_dir
        end
    end

    @installer.files.each do |f|

        check_source! f
        insert_vars_into_destination f

        target_dir = "#{install_base}/#{document_root}/"

        target = nil
        target_file = parse_destination f, target_dir
            
        directory target_dir do
            recursive true
            owner user
            group group 
        end 

        target = target_file.nil? ? "#{target_dir}/" : "#{target_dir}/#{target_file}"

        execute "cp #{cp_flags} #{f[:source]} #{target}" do
            user user
            group group
            cwd final_src_dir
        end


    end

    @installer.templates.each do |t|

        check_source! t
        insert_vars_into_destination t

        target_dir = "#{install_base}/#{document_root}/"

        target_file = parse_destination t, target_dir
            
        directory target_dir do
            recursive true
            owner user
            group group 
        end 

        if target_file.nil? 
            template_file = "#{target_dir}/#{t[:source].split('/').last}"
        else
            template_file = "#{target_dir}/#{target_file}"
        end
        
        template_vars = {}
        template_vars[:params] = js_variables_hash
        template_vars[:version_dir] = "version-#{js_variables_hash[:version]}" if js_variables_hash.has_key? :version
        
        
        template template_file do
            mode '0644'
            owner user
            group group
            local cookbook_name.nil? ? true : false
            source cookbook_name.nil? ? "#{final_src_dir}/#{t[:source]}" : t[:source]
            variables template_vars
        end
    end

    if make_access_rights == true
        execute "chown #{user} -R #{install_base}" unless user.nil?
        execute "chgrp #{group} -R #{install_base}" unless group.nil?
    end
    
    new_resource.updated_by_last_action(true)

end


def insert_vars_into_destination s
    if ( ! s[:destination].nil? and ! s[:destination].empty? )
        @installer.variables.each do |k,v|
            if k == :version
                s[:destination].gsub! "%#{k}%", "version-#{v}"
                s[:destination].gsub! '//', '/'
            else
                s[:destination].gsub! "%#{k}%", v
                s[:destination].gsub! '//', '/'
            end
        end
    end
end

def parse_destination s, target_dir
    target_file = nil
        if ( ! s[:destination].nil? and ! s[:destination].empty? )
            s[:destination].gsub! ' ',''
            elements = s[:destination].split '/'
            target_file = elements.pop unless /\/$/.match s[:destination]
            if elements.size > 0
                target_dir << (elements.join '/')
            end
        end

    Chef::Log.debug "target_file:#{target_file}"
    
    target_file
end

def check_source! hash_element
        if (hash_element[:source].nil? || hash_element[:source].empty?)
                    raise "not valid item in dirs list:#{hash_element.inspect}; should contain not empty :source " 
        end
end




