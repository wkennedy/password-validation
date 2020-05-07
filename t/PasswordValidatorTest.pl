#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use Test::More tests => 21;

use PasswordValidator qw(validate_password);

require_ok("PasswordValidator");

subtest 'PasswordValidator min length test' => sub {
    my ($is_valid, $message) = &validate_password("123");
    ok ($is_valid == "0");
    ok ($message eq PasswordValidator::min_length_error);
};

subtest 'PasswordValidator min length test' => sub {
    my ($is_valid, $message) = &validate_password();
    ok ($is_valid == "0");
    ok ($message eq PasswordValidator::min_length_error);
};

# BEGIN 8-11 tests
subtest 'PasswordValidator 8 to 11 valid test' => sub {
    my ($is_valid, $message) = &validate_password("1234567aB◦");
    ok ($is_valid == "1");
    ok ($message eq PasswordValidator::password_valid);
};

subtest 'PasswordValidator 8 to 11 valid lower bound test' => sub {
    my ($is_valid, $message) = &validate_password("1234AbC*");
    ok ($is_valid == "1");
    ok ($message eq PasswordValidator::password_valid);
};

subtest 'PasswordValidator 8 to 11 valid upper bound test' => sub {
    my ($is_valid, $message) = &validate_password("12345678aB!");
    ok ($is_valid == "1");
    ok ($message eq PasswordValidator::password_valid);
};

subtest 'PasswordValidator 8 to 11 invalid - no symbol - test' => sub {
    my ($is_valid, $message) = &validate_password("12345678abC");
    ok ($is_valid == "0");
    ok ($message eq PasswordValidator::alpha_numeric_symbol_error);
};

subtest 'PasswordValidator 8 to 11 invalid - no number - test' => sub {
    my ($is_valid, $message) = &validate_password("abcdEFGhi!");
    ok ($is_valid == "0");
    ok ($message eq PasswordValidator::alpha_numeric_symbol_error);
};

subtest 'PasswordValidator 8 to 11 invalid - no mixed case - test' => sub {
    my ($is_valid, $message) = &validate_password("12345678ab!");
    ok ($is_valid == "0");
    ok ($message eq PasswordValidator::alpha_numeric_symbol_error);
};
# END 8-11 tests

#BEGIN 12-15 tests
subtest 'PasswordValidator 12 to 15 valid test' => sub {
    my ($is_valid, $message) = &validate_password("123456789abcD*");
    ok ($is_valid == "1");
    ok ($message eq PasswordValidator::password_valid);
};

subtest 'PasswordValidator 12 to 15 valid lower bound test' => sub {
    my ($is_valid, $message) = &validate_password("12345689Abc*");
    ok ($is_valid == "1");
    ok ($message eq PasswordValidator::password_valid);
};

subtest 'PasswordValidator 12 to 15 valid upper bound test' => sub {
    my ($is_valid, $message) = &validate_password("12345689Abcefg*");
    ok ($is_valid == "1");
    ok ($message eq PasswordValidator::password_valid);
};

subtest 'PasswordValidator 12 to 15 invalid mixed case test' => sub {
    my ($is_valid, $message) = &validate_password("12345689abcefg*");
    ok ($is_valid == "0");
    ok ($message eq PasswordValidator::alpha_numeric_error);
};

subtest 'PasswordValidator 12 to 15 invalid - no number - test' => sub {
    my ($is_valid, $message) = &validate_password("abcdefghijkLM");
    ok ($is_valid == "0");
    ok ($message eq PasswordValidator::alpha_numeric_error);
};

#END 12-15 tests

#BEGIN 16-19 tests
subtest 'PasswordValidator 16 to 19 valid test' => sub {
    my ($is_valid, $message) = &validate_password("Abcdefghijklmnopq");
    ok ($is_valid == "1");
    ok ($message eq PasswordValidator::password_valid);
};

subtest 'PasswordValidator 16 to 19 valid lower bound test' => sub {
    my ($is_valid, $message) = &validate_password("Abcdefghijklm123");
    ok ($is_valid == "1");
    ok ($message eq PasswordValidator::password_valid);
};

subtest 'PasswordValidator 16 to 19 valid upper bound test' => sub {
    my ($is_valid, $message) = &validate_password("Abcdefghijklm123!@#");
    ok ($is_valid == "1");
    ok ($message eq PasswordValidator::password_valid);
};

subtest 'PasswordValidator 16 to 19 invalid - no mix case - test' => sub {
    my ($is_valid, $message) = &validate_password("abcdefghijklm123!@#");
    ok ($is_valid == "0");
    ok ($message eq PasswordValidator::alpha_error);
};
#END 16-19 tests

#Begin 20-128 tests
subtest 'PasswordValidator 20+ valid test' => sub {
    my ($is_valid, $message) = &validate_password("abcdefghijklmnopqrstuvwxyz");
    ok ($is_valid == "1");
    ok ($message eq PasswordValidator::password_valid);
};
#End 20-128 tests

#Begin 128+ tests
subtest 'PasswordValidator 20+ valid test' => sub {
    my ($is_valid, $message) = &validate_password("abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz");
    ok ($is_valid == "0");
    ok ($message eq PasswordValidator::max_length_error);
};
#End 128+ tests

pass("All tests run");

1;