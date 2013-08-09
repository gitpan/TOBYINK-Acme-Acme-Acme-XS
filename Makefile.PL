use strict;
use ExtUtils::MakeMaker 6.31;

my $meta = {
  "abstract"           => "an XS-based TOBYINK::Acme::Acme::Acme",
  "author"             => ["Toby Inkster <tobyink\@cpan.org>"],
  "dynamic_config"     => 0,
  "generated_by"       => "Dist::Inkt::Profile::TOBYINK version 0.001, CPAN::Meta::Converter version 2.120921",
  "keywords"           => [],
  "license"            => ["perl_5"],
  "meta-spec"          => {
                            url => "http://search.cpan.org/perldoc?CPAN::Meta::Spec",
                            version => 2,
                          },
  "name"               => "TOBYINK-Acme-Acme-Acme-XS",
  "no_index"           => { directory => ["inc", "t", "xt"] },
  "prereqs"            => { configure => { requires => { "ExtUtils::MakeMaker" => 6.31 } } },
  "provides"           => {
                            "TOBYINK::Acme::Acme::Acme::XS" => { file => "lib/TOBYINK/Acme/Acme/Acme/XS.pm", version => 0.001 },
                          },
  "release_status"     => "stable",
  "resources"          => {
                            bugtracker => {
                                            web => "http://rt.cpan.org/Dist/Display.html?Queue=TOBYINK-Acme-Acme-Acme-XS",
                                          },
                            homepage   => "https://metacpan.org/release/TOBYINK-Acme-Acme-Acme-XS",
                            license    => ["http://dev.perl.org/licenses/"],
                          },
  "version"            => 0.001,
  "x_contributors"     => [],
  "x_provides_scripts" => {},
};

my %dynamic_config;
do {
	# Probably a lot of the following is cargo cult.
	# My XS-fu is not strong.
	#
	
	$dynamic_config{LIBS}   = [''];
	$dynamic_config{DEFINE} = '';
	$dynamic_config{INC}    = '-I.';
	
	if (eval {require ExtUtils::Constant; 1}) {
		my @names = (qw());
		ExtUtils::Constant::WriteConstants(
			NAME         => do { my $name = $meta->{name}; $name =~ s/-/::/g; $name },
			NAMES        => \@names,
			DEFAULT_TYPE => 'IV',
			C_FILE       => 'const-c.inc',
			XS_FILE      => 'const-xs.inc',
		);
	}
	else {
		use File::Copy;
		use File::Spec;
		for my $file ('const-c.inc', 'const-xs.inc') {
			my $fallback = File::Spec->catfile('fallback', $file);
			copy($fallback, $file) or die "Can't copy $fallback to $file: $!";
		}
	}

};

my %WriteMakefileArgs = (
	ABSTRACT           => $meta->{abstract},
	AUTHOR             => $meta->{author},
	DISTNAME           => $meta->{name},
	DISTVNAME          => sprintf('%s-%s', $meta->{name}, $meta->{version}),
	EXE_FILES          => [ map $_->{file}, values %{ $meta->{x_provides_scripts} || {} } ],
	LICENSE            => $meta->{license}[0],
	NAME               => do { my $n = $meta->{name}; $n =~ s/-/::/g; $n },
	VERSION            => $meta->{version},
	%dynamic_config,
);

sub deps
{
	my %r;
	for my $stage (@_)
	{
		for my $dep (keys %{$meta->{prereqs}{$stage}{requires}})
		{
			my $ver = $meta->{prereqs}{$stage}{requires}{$dep};
			$r{$dep} = $ver if !exists($r{$dep}) || $ver >= $r{$dep};
		}
	}
	\%r;
}

my ($build_requires, $configure_requires, $runtime_requires, $test_requires);
if ('ExtUtils::MakeMaker'->VERSION >= 6.6303)
{
	$WriteMakefileArgs{BUILD_REQUIRES}     ||= deps('build');
	$WriteMakefileArgs{CONFIGURE_REQUIRES} ||= deps('configure');
	$WriteMakefileArgs{TEST_REQUIRES}      ||= deps('test');
	$WriteMakefileArgs{PREREQ_PM}          ||= deps('runtime');
}
elsif ('ExtUtils::MakeMaker'->VERSION >= 6.5503)
{
	$WriteMakefileArgs{BUILD_REQUIRES}     ||= deps('build');
	$WriteMakefileArgs{CONFIGURE_REQUIRES} ||= deps('configure', 'test');
	$WriteMakefileArgs{PREREQ_PM}          ||= deps('runtime');	
}
elsif ('ExtUtils::MakeMaker'->VERSION >= 6.52)
{
	$WriteMakefileArgs{CONFIGURE_REQUIRES} ||= deps('configure', 'build', 'test');
	$WriteMakefileArgs{PREREQ_PM}          ||= deps('runtime');	
}
else
{
	$WriteMakefileArgs{PREREQ_PM}          ||= deps('configure', 'build', 'test', 'runtime');	
}

{
	my $minperl = delete $WriteMakefileArgs{PREREQ_PM}{perl};
	exists($WriteMakefileArgs{$_}) && delete($WriteMakefileArgs{$_}{perl})
		for qw(BUILD_REQUIRES TEST_REQUIRES CONFIGURE_REQUIRES);
	if ($minperl and 'ExtUtils::MakeMaker'->VERSION >= 6.48)
	{
		$WriteMakefileArgs{MIN_PERL_VERSION} ||= $minperl;
	}
	elsif ($minperl)
	{
		die "Need Perl >= $minperl" unless $] >= $minperl;
	}
}

sub FixMakefile
{
	return unless -d 'inc';
	my $file = shift;
	
	local *MAKEFILE;
	open MAKEFILE, "< $file" or die "FixMakefile: Couldn't open $file: $!; bailing out";
	my $makefile = do { local $/; <MAKEFILE> };
	close MAKEFILE or die $!;
	
	$makefile =~ s/\b(test_harness\(\$\(TEST_VERBOSE\), )/$1'inc', /;
	$makefile =~ s/( -I\$\(INST_ARCHLIB\))/ -Iinc$1/g;
	$makefile =~ s/( "-I\$\(INST_LIB\)")/ "-Iinc"$1/g;
	$makefile =~ s/^(FULLPERL = .*)/$1 "-Iinc"/m;
	$makefile =~ s/^(PERL = .*)/$1 "-Iinc"/m;
	
	open  MAKEFILE, "> $file" or die "FixMakefile: Couldn't open $file: $!; bailing out";
	print MAKEFILE $makefile or die $!;
	close MAKEFILE or die $!;
}

my $mm = WriteMakefile(%WriteMakefileArgs);
FixMakefile($mm->{FIRST_MAKEFILE} || 'Makefile');
exit(0);

