package Template::Plugin::Group;

=pod

=head1 NAME

Template::Plugin::Group - Template plugin to group lists into simple subgroups

=head1 SYNOPSIS

  # In your Template
  [% USE rows = Group(cells, 3) %]
  
  <table>
  [% FOREACH row IN rows %]
    <tr>
    [% FOREACH cell IN rows %]
      <td class="[% cell.class %]">[% cell.content %]</td>
    [% END %]
    </tr>  
  [% END %]
  <table>

=head1 DESCRIPTION

Template::Plugin::Group is a fairly simple (for now) module for grouping
a list of things into a number of subgroups.

In this intial implementation you can only group ARRAY references, and they
can only be grouped into groups of a numbered size.

In practical terms, you can make columns of things and you can break up a
list into smaller chunks (for example to chop a large lists into a number
of smaller lists for display purposes)

=head1 METHODS

=cut

use strict;
use base 'Template::Plugin';
use Template::Plugin;

use vars qw{$VERSION};
BEGIN {
	$VERSION = '0.01';
}





#####################################################################
# Constructor

=pod

=head2 new \@ARRAY, $cols [, 'pad' ]

Although this is the "new" method, it doesn't really actually create any
objects. It simply takes an array reference, splits up the list into
groups, and returns the whole things as another array reference.

The rest you do normally, with normal Template Toolkit commands.

If there isn't a perfectly divisible number of elements normally the last group
will have less elements than the rest of the groups. If you provide the optional
parameter 'pad', the last group will be padded with additional C<undef> values
so that it has the full number.
 
=cut

sub new {
	my $class = shift;
	unless ( defined $_[1] and $_[1] =~ /^[1-9]\d*$/ ) {
		$class->error('Group constructor argument not a positive integer');
	}
	return $class->_new_array(@_) if ref $_[0] eq 'ARRAY';
	return $class->_new_hash(@_)  if ref $_[0] eq 'HASH';
	$class->error('Group constructor argument not an ARRAY or HASH ref');
}

sub _new_array {
	# Make sure to copy the original array in case they care about it
	my $class = shift;
	my @array = @{shift()};
	my $cols  = shift;

	# Support the padding option
	if ( grep { defined $_ and lc $_ eq 'pad' } @_ ) {
		my $items = scalar(@array) % $cols;
		push @array, (undef) x $items;
	}

	# Create the outside array and pack it
	my @groups = ();
	while ( @array ) {
		push @groups, [ splice @array, 0, $cols ];
	}

	\@groups;
}

sub _new_hash {
	my $class = shift;
	my $hash  = shift;
	my $cols  = shift;
	$class->error('HASH grouping is not implented in this release');

	# Implementation steps.
	# 1. Get the list of keys, sorted in default order
	# 2. Take groups of these and build new hashs for only those
	#    keys, with the same values as the original.
	# 3. Wrap them all inside an ARRAY ref and return.

	# I'm not sure we can do padding in this case...
}

1;

=pod

=head1 TO DO

- Support grouping HASH references

- If everything in the list is an object, support group/sort by method

- Support complex multi-level grouping (I have code for this already, but
it needs to be rewritten and should probably be a separate plugin).

=head1 SUPPORT

Bugs should be submitted via the CPAN bug tracker, located at

L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Template%3A%3APlugin%3A%3AGroup>

For other issues, contact the author

=head1 AUTHOR

Adam Kennedy (Maintainer), L<http://ali.as/>, cpan@ali.as

Thank you to Phase N Australia (L<http://phase-n.com/>) for permitted the
open sourcing and release of this distribution.

=head1 COPYRIGHT

Copyright (c) 2004 Adam Kennedy. All rights reserved.
This program is free software; you can redistribute
it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the
LICENSE file included with this module.

=cut
