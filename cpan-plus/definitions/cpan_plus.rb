define :cpan_plus, :local_lib => [], :raise_error => true, :custom_source => [], :cookbook => 'cpan-plus', :force => false, :skip_test => false, :verbose => true, :environment => {} do 

    my_env = { 'HOME' => params[:home], 'PERL_RL' => '0', ' PERL5_CPANPLUS_HOME' => params[:home]}.merge  params[:environment]
    log my_env

    if params[:action] == :install
        cmd = ''    
        params[:local_lib].each do |path|
            cmd << " eval $(perl -Mlocal::lib=#{path});"
        end
        skip_test = (params[:skip_test] == true)? '1' : '0'
        verbose = (params[:verbose] == true)? '1' : '0'
        cmd << " perl -MCPANPLUS::Backend -e '$rv = CPANPLUS::Backend->new->install( modules => [ qw| #{params[:module_name]} | ], write_install_log => 1, skiptest => #{skip_test}, verbose => #{verbose} ); exit(($rv->ok == 1) ? 0 : 1);'"
        cmd << " 2>&1 "
        execute cmd do
            user params[:user]
            group params[:group]
            environment my_env
            cwd params[:cwd] if params.has_key? :cwd
        end  
    end
    if params[:action] == :reload_index
        cmd = ''
        params[:local_lib].each do |path|
            cmd << " eval $(perl -Mlocal::lib=#{path});"
        end
        cmd << " cpanp x "
        cmd << "--update_source " unless ENV['CPAN_PLUS_UPDATE_SOURCE'] == '0'
        cmd << ' --verbose; '
        execute cmd do
            user params[:user]
            group params[:group]
            environment my_env
            cwd params[:cwd] if params.has_key? :cwd
        end  
    end

    if params[:action] == :set_custom_sources

        cmd = []
        params[:local_lib].each do |path|
            cmd << "eval $(perl -Mlocal::lib=#{path})"
        end
        params[:custom_sources].each do |path|
            cmd << "cpanp /cs --add #{path}"
            cmd << "cpanp /cs --update #{path}"
        end

        #cmd << "cpanp /cs --list"

        directory "#{params[:home]}/.cpanplus/custom-sources/" do
            action :delete
            recursive true
        end

        execute cmd.join ' && ' do
            user params[:user]
            group params[:group]
            environment my_env
            cwd params[:cwd] if params.has_key? :cwd
        end  
    end

    if params[:action] == :configure

        directory "#{params[:home]}/.cpanplus/lib/CPANPLUS/Config/" do
            owner params[:user]
            group params[:group]
            recursive true
        end

        execute "chown #{params[:user]}:#{params[:group]} -R #{params[:home]}/.cpanplus"

        template "#{params[:home]}/.cpanplus/lib/CPANPLUS/Config/User.pm" do
            source 'User.pm'
            variables :home => params[:home], :mirrors => node.cpan_plus.mirrors
            cookbook params[:cookbook]
            owner params[:user]
            group params[:group]
        end  
    end

end
