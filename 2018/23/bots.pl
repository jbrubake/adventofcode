#!/usr/bin/perl

use strict;
use warnings;
use v5.10;

use List::Util qw(max);
use Data::Dumper;

our %BOTS;
while (<>) {
    chomp;
    /pos=<(.*),(.*),(.*)>, r=(.*)/;
    $BOTS{$4} = {x => $1, y => $2, z => $3};
}

our $high_r = max (keys %BOTS);

my $ans = 0;
for $b (keys %BOTS) {
    $ans++ if (abs ($BOTS{$high_r}->{x} - $BOTS{$b}->{x}) +
               abs ($BOTS{$high_r}->{y} - $BOTS{$b}->{y}) +
               abs ($BOTS{$high_r}->{z} - $BOTS{$b}->{z})
               <= $high_r);
}

say "Part 1: $ans";
