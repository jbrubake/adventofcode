#!/usr/bin/perl

use strict;
use warnings;
use v5.10;
use Data::Dumper;
our $MAXSIZE = 10;

my @input = <>;

my @fabric;
# for (my $x = 0; $x < $MAXSIZE; $x++) {
    # for (my $y = 0; $y < $MAXSIZE; $y++) {
        # $fabric[$x][$y] = '.';
    # }
# }

my @intact;
for (@input) {
    my ($id, $lo, $to, $wi, $he) = parse ($_);

    $intact[$id] = 1;

    for (my $y = $to; $y < $to+$he; $y++) {
        for (my $x = $lo; $x < $lo+$wi; $x++) {
            if ($fabric[$x][$y] eq '.') {
                $fabric[$x][$y] = $id;
            } else {
                $intact[$fabric[$x][$y]] = 0;
                $intact[$id] = 0;
                $fabric[$x][$y] = 'X' ;
            }
        }
    }
}
# print Dumper \@fabric;
# exit;
my $overlap = 0;
for (my $y = 0; $y < $MAXSIZE; $y++) {
    for (my $x = 0; $x < $MAXSIZE; $x++) {
        $overlap++ if ($fabric[$x][$y] eq 'X');
    }
}

say "Part 1: $overlap";

for (my $i = 0; $i <= $#intact; $i++){
    say "Part 2: $i" and exit if ($intact[$i] == 1);
}

sub parse {
    shift =~ /#(\d+)\s*@\s*(\d+)+,\s*(\d+)\s*:\s*(\d+)x(\d+)/;
    return $1, $2, $3, $4, $5;
}

