#!/usr/bin/perl

use strict;
use warnings;
use v5.10;

use List::Util qw(max);

use Data::Dumper;

my $map = <>;
chomp $map;

# Remove circles
while ($map =~ s/\([^(]+?\|\)//) {}
say $map;

# Tree root
my $MAP = {n => '#', e => '#', s => '#', w => '#' };

# Current node
my $curr = $MAP;

# Node stack for processing ()
my @pointers = ($MAP);

# Create the map
for my $c (split //, $map) {
    for ($c) {
        # NESW: Add a new node in the right direction
        # and update current node
        when (/N/) { $curr->{n} = {n => '#', e => '#', s => '#', w => '#'}; $curr = $curr->{n}; }
        when (/E/) { $curr->{e} = {n => '#', e => '#', s => '#', w => '#'}; $curr = $curr->{e}; }
        when (/S/) { $curr->{s} = {n => '#', e => '#', s => '#', w => '#'}; $curr = $curr->{s}; }
        when (/W/) { $curr->{w} = {n => '#', e => '#', s => '#', w => '#'}; $curr = $curr->{w}; }
        # (: Push current node onto stack
        when (/\(/) { push @pointers, $curr; }
        # )|: Pop stack to current node to
        # go back to previous room
        when (/\)/) { $curr = pop @pointers; }
        when (/\|/) { $curr = $pointers[-1]; }
        # ^$: Skip
        when (/[\^\$]/) { ; }
        # Error
        default     { die "INVALID CHAR: $c"; }
    }
}

# Find path lengths
my $ans = longest_path ($MAP, 0);
# print Dumper \$MAP;
say $ans;

sub longest_path {
    my $n = shift;
    my $len = shift;

    if ($n->{n} eq '#' and $n->{e} eq '#' and $n->{s} eq'#' and  $n->{w} eq '#') {
        $n->{n} = $len; 
        return $len;
    }

    my ($len_n, $len_e, $len_s, $len_w) = (0, 0, 0, 0);
    $len_n = longest_path ($n->{n}, $len+1) if ($n->{n} ne '#');
    $len_e = longest_path ($n->{e}, $len+1) if ($n->{e} ne '#');
    $len_s = longest_path ($n->{s}, $len+1) if ($n->{s} ne '#');
    $len_w = longest_path ($n->{w}, $len+1) if ($n->{w} ne '#');

    return max $len_n, $len_e, $len_s, $len_w;
}
