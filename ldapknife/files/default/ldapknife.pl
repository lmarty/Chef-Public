#!/usr/bin/perl

###############################################################################
# The primary purpose of ldapknife.pl is to provide a quick and easy way to   #
# to do a mass deletion of an OpenLDAP directory from the command line using  #
# an LDIF file. This is probably most beneficial during the Test/Dev phase of #
# building an OpenLDAP directory. May also be beneficial for generic mass     #
# deletions or purging old or unwanted data.                                  #
#################$Author: Gerald L. Hevener, Jr., M.S. $#######################
#                        $Date: June 13, 2011 $                               #
#                            $Revision: #1 $                                  #
#                   $Id: /usr/local/bin/ldapknife.pl $                        #
#               $HeadURL: /usr/local/bin/ldapknife.pl $                       #
#               $Source: /usr/local/bin/ldapknife.pl $                        #
#        (C) 2011 : Gerald L. Hevener Jr., M.S. All Rights Reserved           #
#        (C) 2011 : jackl0phty.org All Rights Reserved                        #
#       Licensed under the Apache License, Version 2.0 (the "License"),       #
# For any questions regarding the license of this software, please refer to   #
# the actual license at http://www.apache.org/licenses/LICENSE-2.0.txt.       #
###############################################################################
#                        DISCLAIMER OF WARRENTY                               #
# BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY FOR  #
# THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN        #
# OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES      #
# PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED #
# OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF        #
# MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE ENTIRE RISK AS TO #
# THE QUALITY AND PERFORMANCE OF THE SOFTWARE IS WITH YOU. SHOULD THE         #
# SOFTWARE PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL NECESSARY SERVICING,   #
# REPAIR, OR CORRECTION. IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR     #
# AGREED TO IN WRITING WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY  #
# MODIFY AND/OR REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENCE,  #
# BE LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL,   #
# OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE THE     #
# SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING RENDERED  #
# INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIESOR A FAILURE OF THE   #
# SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF SUCH HOLDER OR OTHER  #
# PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.                  #
###############################################################################
################# USE THIS SOFTWARE AT YOUR OWN RISK!!!!#######################
###############################################################################

# Let's be strict and warn
use strict;
use warnings;

# Import required modules
use Getopt::Declare;
use Carp;
use version;
use IPC::Run qw ( run timeout );

# ldapknife.pl VERSION
our $VERSION = qv(1.0.0);

# Declare variables
my $delall;
my $base_search;
my $bind_dn;
my $uri;
my $obj_class;
my $ldif_file;
my $pass;
my $dir;
my $delete_all_dn = 'delete_all_dn.ldif';
my $pwd_ldif_file = 'delete_all_dn.ldif';
my $ldapsearch_cmd;
my $ldif_formatted = 'delete_all_dn_formatted.ldif';
my $ldif_final     = 'deleteAllDN.ldif';
my $line;
my $which_sed = run 'which sed';

# Specify the usage specification for the program
my $specification = <<'USAGE_SPEC';
  --delall	[yes]        Delete ALL data from a given DN!
		   	Requires -b, -D, -H, & --obj!
          		{ delete_all_dn() }
  -delall		[ditto]
  -f			Name of LDIF file
  --help		Print USAGE page
		  		{ $self->usage(0) }
  -help			[ditto]
  --dir			Directory to write LDIF for deletion!
		   	Defaults to PWD.
  -dir			[ditto]
  -b			Search base for LDAP query
  -D			Distinguished Name binddn to bind to the LDAP directory
  -H			Specify URI(s) referring to the ldap server(s)
  --obj			Objectclass (ex. objectclass=*)
  -obj			[ditto]
  --			End of argument list
  			{ finish }
USAGE_SPEC

# Automatically generate help, usage, & version information
# See specification above for details
my $args = Getopt::Declare->new($specification);

# If number of options < 1 print USAGE
if ( $#ARGV < 1 ) {

    print $args->usage() or croak 'Couldn\'t printtool usage';

}

# Delete ALL data from a given DN!
sub delete_all_dn {

    # Get cmd line options
    get_cmd_line_options();

    # Ensure required options are given
    # --delall requires -b, -D, -H, & --obj options
    check_base_search();

    # Check if URI was given by user
    check_uri();

    # Check if Bind DN was given by user
    check_bind_dn();

    # Check if objectclass was given by user
    check_object_class();

    # Check if -d was NOT given
    # Default: Write LDIF to PWD
    check_if_dir_not_given();

    # Check if -d WAS given
    # Write LDIF to $dir/
    check_if_dir_given();

    # End sub with a return
    return;

    # End sub delete_all_dn

}

sub get_cmd_line_options {

    # Get cmd line options
    foreach my $option ( 0 .. $#ARGV ) {

        # Get --delall option
        if ( $ARGV[$option] =~ m/--delall/gmx ) {

            $delall = $ARGV[ $option + 1 ];

            # Uncomment next line to debug
            #print "\$delall = $delall\n";

        }

        # Get -b option
        if ( $ARGV[$option] =~ m/-b/gxm ) {

            $base_search = $ARGV[ $option + 1 ];

            # Add quotes around $base_search
            $base_search = "\"$base_search\"";

            # Uncomment next line to debug
            #print "\$base_search = $base_search\n";

        }

        # Get -D option
        if ( $ARGV[$option] =~ m/-D/gxm ) {

            $bind_dn = $ARGV[ $option + 1 ];

            # Add quotes around bind_dn
            $bind_dn = "\"$bind_dn\"";

            # Uncomment next line to debug
            #print "\$bind_dn = $bind_dn\n";

        }

        # Get -H option
        if ( $ARGV[$option] =~ m/-H/gxm ) {

            $uri = $ARGV[ $option + 1 ];

            # Add quotes around $uri
            $uri = "\"$uri\"";

            # Uncomment next line to debug
            #print "\$uri = $uri\n"

        }

        # Get -dir option
        if ( $ARGV[$option] =~ m/--dir|-dir/gxm ) {

            $dir = $ARGV[ $option + 1 ];

            # Uncomment next line to debug
            #print "\$dir = $dir\n";

        }

        # Get --obj option
        if ( $ARGV[$option] =~ m/--obj|-obj/gxm ) {

            $obj_class = $ARGV[ $option + 1 ];

            # Add quotes around $obj_class
            $obj_class = "\"$obj_class\"";

            # Uncomment next line to debug
            #print "\$obj_class = $obj_class\n";

        }

        # Get -f option
        if ( $ARGV[$option] =~ m/-f/gxm ) {

            $ldif_file = $ARGV[ $option + 1 ];

            # Add quotes around $ldif_file
            $ldif_file = "$ldif_file";

            # Uncomment next line to debug
            #print "\$ldif_file = $ldif_file\n";

        }

        # Get -w option
        if ( $ARGV[$option] =~ m/-w/gxm ) {

            $pass = $ARGV[ $option + 1 ];

            # Add quotes around $ldif_file
            $pass = $pass;

            # Uncomment next line to debug
            #print "\$pass = $pass\n";

        }

        # End foreach loop
    }

    # End sub with a return
    return;

    # End sub get_cmd_line_options
}

sub check_base_search {

    if ( !$base_search ) {

        # Tell user about required options
        print "\n" or croak;
        print
"\tOption --delall requires -b, -D, -H & --obj options to be given!\n\n"
          or croak;
        print "\tExecute ./ldapknife --help for the help menu.\n"
          or croak;
        print
"\n\tExample: ./ldapknife --delall yes -D \"cn=Manager,dc=example,dc=com\" \\\
         -b \"cn=Users,dc=example,dc=com\" -H ldap://ldap.example.com \\\
         -d /tmp -f delete_ldif.ldif -w SECRET_PASS_HERE\n" or croak;
        print "\n"                                          or croak;

        # Base search not given. Exit ldapknife.pl
        exit;

    }

    # End sub with a return
    return;

    # End sub check_base_search

}

sub check_uri {

    if ( !$uri ) {

        # Tell user about required options
        print "\n" or croak;
        print
"\tOption --delall requires -b, -D, -H & --obj options to be given!\n\n"
          or croak;
        print "\tExecute ./ldapknife --help for the help menu.\n"
          or croak;
        print
"\n\tExample: ./ldapknife --delall yes -D \"cn=Manager,dc=example,dc=com\" \\\
         -b \"cn=Users,dc=example,dc=com\" -H ldap://ldap.example.com \\\
         -d /tmp -f delete_ldif.ldif -w SECRET_PASS_HERE\n" or croak;
        print "\n"                                          or croak;

        # URI not given. Exit ldapknife.pl
        exit;

    }

    # End sub with a return
    return;

    # End sub check_uri

}

sub check_bind_dn {

    if ( !$bind_dn ) {

        # Tell user about required options
        print "\n" or croak;
        print
"\tOption --delall requires -b, -D, -H & --obj options to be given!\n\n"
          or croak;
        print "\tExecute ./ldapknife --help for the help menu.\n"
          or croak;
        print
"\n\tExample: ./ldapknife --delall yes -D \"cn=Manager,dc=example,dc=com\" \\\
         -b \"cn=Users,dc=example,dc=com\" -H ldap://ldap.example.com \\\
         -d /tmp -f delete_ldif.ldif -w SECRET_PASS_HERE\n" or croak;
        print "\n"                                          or croak;

        # Bind DN not given. Exit ldapknife.pl
        exit;

    }

    # End sub with a return
    return;

    # End sub check_bind_dn

}

sub check_object_class {

    if ( !$obj_class ) {

        # Tell user about required options
        print "\n" or croak;
        print
"\tOption --delall requires -b, -D, -H & --obj options to be given!\n\n"
          or croak;
        print "\tExecute ./ldapknife --help for the help menu.\n"
          or croak;
        print
"\n\tExample: ./ldapknife --delall yes -D \"cn=Manager,dc=example,dc=com\" \\\
		 -b \"cn=Users,dc=example,dc=com\" -H ldap://ldap.example.com \\\
   		 -d /tmp -f delete_ldif.ldif -w SECRET_PASS_HERE\n" or croak;
        print "\n"                                       or croak;

        # Object class not given. Exit ldapknife.pl
        exit;

    }

    # End sub with a return
    return;

    # End sub check_object_class

}

sub check_if_dir_not_given {

    if ( !$dir ) {

        # Inform user what we're doing
        print "Writing $pwd_ldif_file LDIF to PWD... This may take a while!\n"
          or croak;

        # Execute $ldapsearch_cmd to build $pwd_ldif_file
        $ldapsearch_cmd =
"ldapsearch -x -w $pass -H $uri -D $bind_dn -b $base_search $obj_class > $pwd_ldif_file";
        system $ldapsearch_cmd;

        # Fix line wrapping
        my $perl_cmd =
          "perl -p0e \'s/\n //g\' $pwd_ldif_file > $ldif_formatted";
        system $perl_cmd;

        # Open LDIF file $dir/$ldif_file for read
        open my $LDIF_IN, '<', "$ldif_formatted"
          or croak("Can't open $dir/$ldif_file: $!");

        # Open LDIF file $dir/$delete_all_dn for write
        open my $LDIF_OUT, '>', "$delete_all_dn"
          or croak("Can't open $dir/$delete_all_dn: $!");

        # loop through LDIF
        while (<$LDIF_IN>) {

            # populate $line with $_
            $line = $_;

            #replace objectClass user with inetOrgPerson
            if ( $line =~ m/dn:\s/gxm ) {

                #write to LDIF_OUT handle to create LDIF
                print {$LDIF_OUT} "$line" or croak;
                print {$LDIF_OUT} "changetype: delete\n\n" or croak;

            }

            # close while loop
        }

        # close file handles to reclaim resources
        close $LDIF_IN
          or croak "Can't close $dir/$ldif_formatted: $!\n";
        close $LDIF_OUT
          or croak "Can't close $dir/$delete_all_dn: $!\n";

        # Need sed to delete blank line
        # at end of $dir/$ldif_final
        #my $which_sed = run "which sed";

        # Check if sed is installed
        if ( $which_sed == 1 ) {

            # Build sed command
            my $sed_cmd = "sed '\$d' $delete_all_dn > $ldif_final";

            # Execute sed command to delete last empty line in $dir/$ldif_final
            # using run from IPC::Run;
            run $sed_cmd;

        }
        else {

            # Sed doesn't seem to be installed
            # Tell user to install it
            print "Sed doesn't seem to be installed! Please install it.\n"
              or croak;

        }

        # Pass $dir/$delete_all_dn to ldapmodify
        # to delete all dn's in the file
        my $ldapmodify_cmd =
          "ldapmodify -x -w $pass -H $uri -D $bind_dn -f $ldif_final";

        system $ldapmodify_cmd;

    }

    # End sub with return
    return;

    # End sub check_if_dir_not_given

}

sub check_if_dir_given {

    # If -f not given, set $ldif_file to dn_2_delete.ldif
    if ( ($dir) && ( !$ldif_file ) ) {

        $ldif_file = 'dn_2_delete.ldif';

    }

    # Inform user what we're doing
    print "Writing $ldif_file LDIF to $dir... This may take a while!\n"
      or croak;

    # Execute $ldapsearch_cmd to build $delete_all_dn
    $ldapsearch_cmd =
"ldapsearch -x -w $pass -H $uri -D $bind_dn -b $base_search $obj_class > $dir/$ldif_file";
    system $ldapsearch_cmd;

    # Fix line wrapping
    my $perl_cmd =
      "perl -p0e \'s/\n //g\' $dir/$ldif_file > $dir/$ldif_formatted";
    system $perl_cmd;

    # Open LDIF file $dir/$ldif_file for read
    open my $LDIF_IN, '<', "$dir/$ldif_formatted"
      or croak("Can't open $dir/$ldif_formatted: $!");

    # Open LDIF file $dir/$delete_all_dn for write
    open my $LDIF_OUT, '>', "$dir/$delete_all_dn"
      or croak("Can't open $dir/$delete_all_dn: $!");

    # loop through LDIF
    while (<$LDIF_IN>) {

        # populate $line with $_
        $line = $_;

        #replace objectClass user with inetOrgPerson
        if ( $line =~ m/dn:\s/gxm ) {

            #write to LDIF_OUT handle to create LDIF
            print {$LDIF_OUT} "$line" or croak;
            print {$LDIF_OUT} "changetype: delete\n\n" or croak;

        }

        # close while loop
    }

    # close file handles to reclaim resources
    close $LDIF_IN
      or croak "Can't close $dir/$ldif_formatted: $!\n";
    close $LDIF_OUT
      or croak "Can't close $dir/$delete_all_dn: $!\n";

    if ( $which_sed == 1 ) {

        # Build sed command
        my $sed_cmd2 = "sed '\$d' $dir/$delete_all_dn > $dir/$ldif_final";

        # Execute sed command to delete last empty line in $dir/$ldif_final
        # using run from IPC::Run
        run $sed_cmd2;

    }
    else {

        # Sed doesn't seem to be installed
        # Tell user to install it
        print "Sed doesn't seem to be installed! Please install it.\n"
          or croak;

    }

    # Pass $dir/$delete_all_dn to ldapmodify
    # to delete all dn's in the file
    my $ldapmodify_cmd =
      "ldapmodify -x -w $pass -H $uri -D $bind_dn -f $dir/$ldif_final";
    system $ldapmodify_cmd;

    # End sub with a return
    return;

    # End sub check_if_dir_given
}
