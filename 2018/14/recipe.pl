#!/usr/bin/perl

use strict;
use warnings;
use v5.10;

our $INPUT = <>;

our @RECIPES = (3, 7);
our @ELVES = (0, 1);

my $answers = 0;
my ($x, $y) = (0, 0);
for (my $i = 0; ; $i++) {
    # print_recipes ($i);
    $ELVES[0] = (($ELVES[0] + 1 + $RECIPES[$ELVES[0]] + scalar @RECIPES) % scalar @RECIPES);
    $ELVES[1] = (($ELVES[1] + 1 + $RECIPES[$ELVES[1]] + scalar @RECIPES) % scalar @RECIPES);
    my $new = $RECIPES[$ELVES[0]] + $RECIPES[$ELVES[1]];
    push @RECIPES, split //, $new;
    if (scalar @RECIPES == $INPUT + 10) {
        say "Part 1: ", join '', @RECIPES[$#RECIPES-9..$#RECIPES];
        $answers++;
    }
    if ($RECIPES[$x] == substr $INPUT, $y, 1) {
        $y++; # Next round, check next character of INPUT
        $x++; # and next recipe
    } else {
        $y = 0; # Reset INPUT counter
        $x = $x - $y + 1; # and reset recipe counter to
                          # start point + 1
    }
    if ($y == length $INPUT) {
        say "Part 2: ", $x - length $INPUT;
        $answers++;
    }

    exit if ($answers == 2);
}


sub print_recipes {
    print "$_[0]: ";
    for my $i (0..$#RECIPES) {
        if ($i == $ELVES[0]) {
            print "($RECIPES[$i])";
        } elsif ($i == $ELVES[1]) {
            print "[$RECIPES[$i]]";
        } else {
            print " $RECIPES[$i] ";
        }
    }
    say "";
}
