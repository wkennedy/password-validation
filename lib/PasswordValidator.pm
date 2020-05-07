#!/usr/bin/perl
package PasswordValidator;

use strict;
use warnings FATAL => 'all';
use base qw(Exporter);

our @EXPORT_OK = qw(validate_password);

# Write a Perl function that takes in a password and checks whether it's valid.  The password should follow the following rule:
#
# Passwords must be at least 8 characters long.
#     Between 8-11: requires mixed case letters, numbers and symbols
#     Between 12-15: requires mixed case letters and numbers
#     Between 16-19: requires mixed case letters
#     20+: any characters desired
use constant {
    password_valid             => "The password is valid",
    min_length_error           => "Password must be at least 8 characters",
    max_length_error           => "Password can't be more than 128 characters",
    alpha_numeric_symbol_error => "Password must contain mixed case letters, numbers and symbols (example: !@#\$\%^&*<>?+)",
    alpha_numeric_error        => "Password must contain mixed case letters and numbers",
    alpha_error                => "Password must contain mixed case letters and numbers"
};

sub validate_password {
    my $password = shift;
    if(!defined $password) {
        return(0, min_length_error);
    }

    my $password_length = length($password);

    if ($password_length < 8) {
        return(0, min_length_error);
    }
    elsif ($password_length <= 11) {
        return validate_alpha_numeric_symbols($password);
    }
    elsif ($password_length <= 15) {
        return validate_alpha_numeric($password);
    }
    elsif ($password_length <= 19) {
        return validate_alpha($password);
    }
    elsif ($password_length <= 128) {
        return(1, password_valid);
    }
    else {
        # OWASP: Maximum password length should not be set too low, as it will prevent users from creating passphrases.
        # Typical maximum length is 128 characters. It is important to set a maximum password length to prevent long
        # password Denial of Service attacks.
        return(0, max_length_error);
    }
}

sub validate_alpha_numeric_symbols {
    my $password = shift;
    #OWASP: Allow usage of all characters including unicode and whitespace. There should be no password composition
    #rules limiting the type of characters permitted.
    if ($password =~ m/^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[^a-zA-Z0-9\s])/) {
        return(1, password_valid);
    }
    else {
        return(0, alpha_numeric_symbol_error);
    }
}

sub validate_alpha_numeric {
    my $password = shift;
    if ($password =~ m/^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])/) {
        return(1, password_valid);
    }
    else {
        return(0, alpha_numeric_error);
    }
}

sub validate_alpha {
    my $password = shift;
    if ($password =~ m/^(?=.*[a-z])(?=.*[A-Z])/) {
        return(1, password_valid);
    }
    else {
        return(0, alpha_error);
    }
}