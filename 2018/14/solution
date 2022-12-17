#!/usr/bin/perl

use strict;
use warnings;
use v5.10;

our $INPUT = <>;
chomp $INPUT;
our @RECIPES = (3, 7);
our @ELVES = (0, 1);

my $answers = 0;
my $part1 = 0;
my $part2 = 0;
my ($x, $y) = (0, 0);

while ($answers != 2) {
    $ELVES[0] = (($ELVES[0] + 1 + $RECIPES[$ELVES[0]] + scalar @RECIPES) % scalar @RECIPES);
    $ELVES[1] = (($ELVES[1] + 1 + $RECIPES[$ELVES[1]] + scalar @RECIPES) % scalar @RECIPES);
    my $new = $RECIPES[$ELVES[0]] + $RECIPES[$ELVES[1]];
    push @RECIPES, split //, $new;

    if (!$part1) {
        if (scalar @RECIPES == $INPUT + 10) {
            $part1 = join '', @RECIPES[$#RECIPES-9..$#RECIPES];
            $answers++;
        }
    }

    if (!$part2) {
        if ($RECIPES[$x] == int(substr $INPUT, $y, 1)) {
            $y++; # Next round, check next character of INPUT
            $x++; # and next recipe
        } else {
            $y = 0; # Reset INPUT counter
            $x = $x - $y + 1; # and reset recipe counter to start point + 1
        }
        if ($y == length $INPUT) {
            $part2 = $x - length $INPUT;
            $answers++;
        }
    }
}

say "Part 1: ", $part1;
say "Part 2: ", $part2;

