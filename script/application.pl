use strict;
use warnings FATAL => 'all';
use Mojolicious::Lite;

use File::Basename;
use lib dirname (__FILE__) . "/../lib";

use PasswordValidator qw(validate_password);

my $log = Mojo::Log->new;

get '/' => 'form';

put '/removeRedundantParentheses' => sub {
    my $c = shift;

    # Prevent double form submission with redirect
    my $value = $c->param('pw');
    $log->debug("password submitted by user, attempting validation");
    my ($is_valid, $message) = &validate_password($value);
    $log->debug("password validation finished, returning result response");

    $c->flash(confirmation => $message . ": " . $value);
    $c->redirect_to('form');
};

app->start;
__DATA__

@@ form.html.ep
<!DOCTYPE html>
<html>
  <body>
    % if (my $confirmation = flash 'confirmation') {
      <p><%= $confirmation %></p>
    % }
    %= form_for removeRedundantParentheses => begin
      %= label_for pw => 'Enter password to validate: '
      %= text_field pw => ''
      %= submit_button
    % end
  </body>
</html>