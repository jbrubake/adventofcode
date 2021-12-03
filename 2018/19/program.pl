#!/usr/bin/perl

use strict;
use warnings;
use v5.10;

my ($a, $c, $e) = (1, 0, 0);
our $RANGE = 10551314;

for ($e = 1, $c = 1; $c <= $RANGE ; $e++) {
    $a += $c if (($c * $e) == $RANGE);
    if ($e > $RANGE) {
        $c++;
        $e = 0;
    }
}

say $a;
