package TOBYINK::Acme::Acme::Acme::XS;

use strict;
use warnings;

BEGIN {
	$TOBYINK::Acme::Acme::Acme::XS::AUTHORITY = 'cpan:TOBYINK';
	$TOBYINK::Acme::Acme::Acme::XS::VERSION   = '0.001';
}

require XSLoader;
XSLoader::load('TOBYINK::Acme::Acme::Acme::XS', our $VERSION);

sub new { bless [], $_[0] }
sub acme_acme { &_acme_acme() }

1;

__END__

=pod

=encoding utf-8

=head1 NAME

TOBYINK::Acme::Acme::Acme::XS - an XS-based TOBYINK::Acme::Acme::Acme

=head1 DESCRIPTION

=head2 Methods

=over

=item C<new>

=item C<acme_acme>

=back

=head1 BUGS

Please report any bugs to
L<http://rt.cpan.org/Dist/Display.html?Queue=TOBYINK-Acme-Acme-Acme-XS>.

=head1 SEE ALSO

=head1 AUTHOR

Toby Inkster E<lt>tobyink@cpan.orgE<gt>.

=head1 COPYRIGHT AND LICENCE

This software is copyright (c) 2013 by Toby Inkster.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.


=head1 DISCLAIMER OF WARRANTIES

THIS PACKAGE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED
WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF
MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.

