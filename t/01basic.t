=pod

=encoding utf-8

=head1 PURPOSE

Test that TOBYINK::Acme::Acme::Acme::XS compiles and works.

=head1 AUTHOR

Toby Inkster E<lt>tobyink@cpan.orgE<gt>.

=head1 COPYRIGHT AND LICENCE

This software is copyright (c) 2013 by Toby Inkster.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.


=cut

use strict;
use warnings;
use Test::More;

use_ok('TOBYINK::Acme::Acme::Acme::XS');

my $acme = 'TOBYINK::Acme::Acme::Acme::XS'->new;
is($acme->acme_acme, 42);

done_testing;

