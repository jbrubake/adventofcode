#!/usr/bin/perl

use strict;
use warnings;
use v5.10;

my @input = <>;

my (%found, $freq);
while () {
    foreach (@input) {
        # Running total
        $freq += $_;
        # Found the answer if it was seen before
        say "Part 2: $freq" and exit if (exists $found{$freq});
        # Mark what freqs have been seen
        $found{$freq} = 1;
    }
}

