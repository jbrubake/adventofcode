#!/usr/bin/perl

use strict;
use warnings;
use v5.10;

our $DEPTH = 1191;
our %TARGET = (x => 6, y => 797);
our $ELMOD = 20183;
our $TYPEMOD = 3;
our $ROCK = 0;
our $WET = 1;
our $NARR = 2;

our %RISKS;

my $risk = 0;
for my $y (0..$TARGET{y}) {
    for my $x (0..$TARGET{x}) {
        my $i = get_index ($x, $y);
        say "$x,$y = $i";
        # $risk += $r;
    }
}

say "Part 1: $risk";

sub get_index {
    my ($x, $y) = ($_[0], $_[1]);

    my $r = 0;
    if (exists $RISKS{$x,$y}) {
        $r = $RISKS{$x,$y};
    } elsif ($x == 0 and $y == 0) {
        $r = 0;
    } elsif ($x == $TARGET{x} and $y == $TARGET{y}) {
        $r = 0;
    } elsif ($x == 0) {
        $r = $y * 48271;
    } elsif ($y == 0) {
        $r = $x * 16807;
    } else {
        $r = get_index ($x-1, $y) * get_index ($x, $y-1);
    }
    
    $RISKS{$x,$y} = $r;
    return $r;
}

sub get_erosion_level {
    my ($x, $y) = ($_[0], $_[1]);

    return (get_index ($x, $y) + $DEPTH) % $ELMOD;
}

sub get_region_type {
    my ($x, $y) = ($_[0], $_[1]);

    my $el = get_erosion_level ($x, $y);

    return $el % $TYPEMOD;
}


