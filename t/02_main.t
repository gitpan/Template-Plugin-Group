#!/usr/bin/perl -w

# Template::Plugin::Group basic functionality tests

use strict;
use lib ();
use UNIVERSAL 'isa';
use File::Spec::Functions ':ALL';
BEGIN {
	$| = 1;
	unless ( $ENV{HARNESS_ACTIVE} ) {
		require FindBin;
		chdir ($FindBin::Bin = $FindBin::Bin); # Avoid a warning
		lib->import( catdir( updir(), updir(), 'modules') );
	}
}





# Does everything load?
use Test::More 'tests' => 4;
use Template::Plugin::Group ();



# Prepare
my $TPG = 'Template::Plugin::Group';
my $testdata = [ 'foo', 'bar', 'baz' ];
my $backup   = [ 'foo', 'bar', 'baz' ];
my $grouped  = [ [ 'foo', 'bar' ], [ 'baz' ] ];
my $padded   = [ [ 'foo', 'bar' ], [ 'baz', undef ] ];

# Do a normal grouping
is_deeply( $TPG->new( $testdata, 2 ), $grouped, 'Normal grouping groups correctly' );
is_deeply( $testdata, $backup, 'Normal grouping doesnt break original ARRAY ref' );

# Do a padded grouping
is_deeply( $TPG->new( $testdata, 2, 'pad' ), $padded, 'Padded grouping groups correctly' );
is_deeply( $testdata, $backup, 'Padded grouping doesnt break original ARRAY ref' );

1;
