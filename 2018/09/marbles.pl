#!/usr/bin/perl

use strict;
use warnings;
use v5.10;

use List::Util qw(max);

<> =~ /(\d+) players; last marble is worth (\d+) points/;
my ($players, $last) = ($1, $2);

my @marbles = (0);
my @players = (0) x $players;
my $i = 0;

my $marble_val = 1;
# Loop until we play all marbles
MARBLE: while () {
    for my $player (@players) {
        # Break out if we played all the marbles
        last MARBLE if ($marble_val > $last);
        # Insert only if marble is a multiple of 23
        if ($marble_val % 23 != 0) {
            $i = insert_cw ($i, 1, scalar @marbles);
            splice @marbles, $i, 0, $marble_val;
        } else {
            # Marble is a multiple of 23
            $player += $marble_val; # Score marble
            $i = insert_ccw ($i, 7, scalar @marbles);
            # Score marble and remove it
            $player += $marbles[$i];
            splice @marbles, $i, 1; 
        }
        # Nexxt marble
        $marble_val++;
    }
}
print "Part 1: " . max (@players) . "\n";

sub insert_cw {
    my $i = shift;
    my $offset = shift;
    my $size = shift;

    return ($i + $offset) % $size + 1;
}

sub insert_ccw {
    my $i = shift;
    my $offset = shift;
    my $size = shift;

    return ($i - $offset) % $size;
}
