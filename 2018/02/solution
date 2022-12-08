#!/usr/bin/perl

use strict;
use warnings;
use v5.10;

use List::Util qw(min max);

my @box_ids;
while (<>) {
    chomp;
    push @box_ids, $_;
}

# Part 1
my ($total_twos, $total_threes); # Track total 2s and 3s
for my $id (@box_ids) {
    my %count; # Resets count each iteration
    my ($twos, $threes) = (0, 0);

    # Get a count of each character
    for my $c (split //, $id) {
        $count{$c} += 1;
    }

    # Count how many characters occurred two or three times
    for my $k (keys %count) {
        $twos++   if ($count{$k} == 2);
        $threes++ if ($count{$k} == 3);
    }

    # Add to totals
    $total_twos   += min $twos, 1;
    $total_threes += min $threes, 1;
}

say "Part 1: " . $total_twos * $total_threes;

# Part 2
# Get first box and remove from list
while (my $box_a = shift @box_ids) {
    # Check against all other boxes
    for my $box_b (@box_ids) {
        my ($ans, $n);
        # Break box ids up
        my @a = split //, $box_a;
        my @b = split //, $box_b;
        # Check each character
        while (@a) {
            $a = shift @a;
            $b = shift @b;
            # If characters match, add to possible
            # answer and check next character
            if ($a eq $b) {
                $ans .= $a;
                next;
            } else {
                # Otherwise we found another mismatched character
                $n++;
            }
        }
        # Found the answer if only one character was different
        say "Part 2: $ans" and exit if ($n == 1); 
    }
}
