###############################################
###
###  Configuration structure for CPANPLUS::Config::User
###
###############################################

#last changed: Tue Dec  4 07:37:14 2012 GMT

### minimal pod, so you can find it with perldoc -l, etc
=pod

=head1 NAME

CPANPLUS::Config::User

=head1 DESCRIPTION

This is a CPANPLUS configuration file. Editing this
config changes the way CPANPLUS will behave

=cut

package CPANPLUS::Config::User;

use strict;

sub setup {
    my $conf = shift;

    ### conf section    
    $conf->set_conf( allow_build_interactivity => 1 );    
    $conf->set_conf( allow_unknown_prereqs => 1 );    
    $conf->set_conf( base => '<%= @home %>/.cpanplus' );    
    $conf->set_conf( buildflags => '--installdirs site' );    
    $conf->set_conf( cpantest => 0 );    
    $conf->set_conf( cpantest_mx => '' );    
    $conf->set_conf( cpantest_reporter_args => {} );    
    $conf->set_conf( debug => 1 );    
    $conf->set_conf( dist_type => '' );    
    $conf->set_conf( email => 'cpanplus@example.com' );    
    $conf->set_conf( enable_custom_sources => 1 );    
    $conf->set_conf( extractdir => '' );    
    $conf->set_conf( fetchdir => '' );    
    $conf->set_conf( flush => 1 );    
    $conf->set_conf( force => 0 );    
    $conf->set_conf( histfile => '<%= @home %>/.cpanplus/history' );    
    $conf->set_conf( hosts => [
    # <%- @mirrors.each do |m| %>
         {
            'path' => '<%= m[:path] %>',
            'scheme' => '<%= m[:scheme] %>',
            'host' => '<%= m[:host] %>'
         },
    #<%- end %>
    ] );    
    $conf->set_conf( lib => [] );    
    $conf->set_conf( makeflags => '' );    
    $conf->set_conf( makemakerflags => 'INSTALLDIRS=site' );    
    $conf->set_conf( md5 => 1 );    
    $conf->set_conf( no_update => 0 );    
    $conf->set_conf( passive => 1 );    
    $conf->set_conf( prefer_bin => 0 );    
    $conf->set_conf( prefer_makefile => 0 );    
    $conf->set_conf( prereqs => 1 );    
    $conf->set_conf( shell => 'CPANPLUS::Shell::Default' );    
    $conf->set_conf( show_startup_tip => 1 );    
    $conf->set_conf( signature => 0 );    
    $conf->set_conf( skiptest => 0 );    
    $conf->set_conf( source_engine => 'CPANPLUS::Internals::Source::SQLite' );    
    $conf->set_conf( storable => 0 );    
    $conf->set_conf( timeout => 300 );    
    $conf->set_conf( verbose => 1 );    
    $conf->set_conf( write_install_logs => 1 );    
    
    
    ### program section    
    $conf->set_program( editor => '<%= `which vi`.chomp! %>' );    
    $conf->set_program( make => '<%= `which make`.chomp! %>' );    
    $conf->set_program( pager => '<%= `which less`.chomp! %>' );    
   # $conf->set_program( perlwrapper => '/usr/bin/cpanp-run-perl' );    
    $conf->set_program( shell => '<%= `which bash`.chomp! %>' );    
   # $conf->set_program( sudo => '<%= `which sudo`.chomp! %>' );    
    
    


    return 1;
}

1;

