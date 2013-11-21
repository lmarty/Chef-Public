# Description
light weight resource for installing java script applications/libraries

# Requirements
 - tar
 - wget

# Attributes

# Usage

    js_application 'my JavaScript application' do
        tarball 'http://some.ftp.host/my-application.tar.gz'
        install_base '/home/user/my-application/root/'
        dirs [ { :source => 'www_files'  } ]
        action :install
    end

## Resource parameters

 -  tarball - http url to tarball where distribution files where are placed
 -  cookbook - contrariwise one may store distribution files as cookbook's files in files/default/js-app directory.
    so 'cookbook' is the name of the cookbook, see 'Installing from cookbook files' section.

 -  user - the owner for files to be installed, default value is nil
 -  group - the group for files to be installed, default value is nil 

 -  install_base - installation root, default value is nil, so you need to define it or rely upon $PERL_MB_OPT 
    environment var, see "Installing with default install_base"
    
 -  document_root - will be added to install_base, default value is 'htdocs', 
    so everything is installed into 'install_base/document_root/'

 -  dirs - list of directories to be installed, see "Installing directories" section
 -  files - list of files to be installed, see "Installing files" section
 -  templates - list of templates to be installed, see "Installing templates" section

 -  variables - hash of variables to get used in templates files and :destination template strings, 
    see "Installing templates" and "Destination template strings" sections 
        
 -  cleanup - whether to delete "install_base/document_root" directory before installing, default value is 'false'

# Examples of usage

## Installing with default install_base

one my choose not to define install_base explicitly and setup environment via perl local::lib tool:

    eval $(perl -Mlocal::lib=/home/user/my-application/root/)
    chef-client

this will result in installing into '/home/user/my-application/root/'

## Installing from tarball

    tarball 'ftp://some.ftp.host/my-application.tar.gz'    

my-application.tar.gz should contain 'my-application' directory - standard way of packaging

## Installing from cookbook files

    cookbook 'my-application'

cookbook 'my-application' should contain files/default/js-app/ directory with files to install and is treated as chef remote_directory
resource


## Installing from local source

    local_source_dir '/home/user/src/my-application/'
    
local_source_dir should be directory with files to install, this way of installing is used in cucumber tests


## Installing files

    files [
        { :source => 'web_files/index.html', },
        { :source => 'web_files/css/main.css', :destination => 'css/' }
        { :source => 'web_files/img/picture.gif', :destination => 'images/my_picture.gif' }
    ]

this will install files:

  - 'web_files/index.html' as 'install_base/document_root/index.html'
  - 'web_files/css/main.css' as 'install_base/document_root/css/main.css'
  - 'web_files/img/picture.gif' as 'install_base/document_root/images/my_picture.gif'
  

## Installing directories

    dirs [
        { :source => 'web_files', },
        { :source => 'css', :destination => 'css2/' }
    ]

this will install directories content:

  - 'web_files/' into 'install_base/document_root/'
  - 'css/' into 'install_base/document_root/css2/'
  
## Installing templates

in the way of installing templates are the files. The only difference variables gets interpolated into templates content:

    templates [
        { :source => 'templates/index.erb', :destination => 'index.html' }
    ]
    variables => {
        :foo => 'foo-value'
    }
  
this will install template 'templates/index.erb' as 'install_base/document_root/index.html' and given that
template contains "<%= @params[:foo] %>" :foo variable gets interpolated with 'foo-value'


## Destination template strings 

:destination keys in dir/files/templates lists could contain arbitrary numbers of %template% strings:

    dirs [
        { :source => 'css', :destination => 'css/%prefix%' }
    ]

    variables => {
        :prefix => 'beta'
    }

this will install directories content 'css/' into 'install_base/document_root/css/beta/'

the only exception is %version%  template string which result in a little bit different substitution:

    dirs [
        { :source => 'css', :destination => '%version%/css' }
    ]

    variables => {
        :version => '0.0.1'
    }

this will install directories content 'css/' into 'install_base/document_root/version-0.0.1/css/', also
version_dir variable will be passed into any templates


## Changing document_root

by default document_root is 'htdocs', you can change it with:

    document_root 'public'
    
    
