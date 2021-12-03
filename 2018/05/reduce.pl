#!/usr/bin/perl

use strict;
use warnings;
use v5.10;

use List::Util qw(min);

my $polymer = <>;
chomp $polymer;

say "Part 1: " . reduce ($polymer);

my $short_len = length $polymer;
foreach my $c ('a'..'z'){
    my $p = $polymer;

    $p =~ s/$c//g;
    $p =~ s/\U$c//g;

    $short_len = min ($short_len, reduce($p));
}
say "Part 2: $short_len";

sub reduce {
    my $polymer = shift;

    while (1) {
        my $change = 0;

        foreach my $c ('a'..'z'){
            my $C = uc $c;
            $change = 1 if($polymer =~ s/$c$C//g);
            $change = 1 if($polymer =~ s/$C$c//g);
        }
        last if($change == 0);
    }

    return length $polymer;
}


