#!/usr/bin/perl -w
use strict;
use warnings FATAL => 'all';
use File::Basename;
use lib dirname (__FILE__) . "/../lib";

use PasswordValidator qw(validate_password);

my $arg_count = $#ARGV + 1;
if ($arg_count != 1) {
    print "\nUsage: ValidatePassword.pl <password>\n";
    exit;
}

my $password=$ARGV[0];
my ($is_valid, $message) = &validate_password($password);

print "$message\n";