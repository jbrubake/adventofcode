#!/usr/bin/perl

use strict;
use warnings;
use v5.10;

use Data::Dumper;

# Get starting pots
$_ = <>;
chomp;
s/[^#.]+//;
my @pots = split '', $_;
our $NUM_POTS = $#pots;

# Get the rules
my %rules;
while (<>) {
    next if ($_ eq "\n");
    chomp;
    /(.*) => (.*)/;
    $rules{$1} = $2;
}

# Problem constants
our $PART1_MIN = 20;
our $CONVERGE_MIN = 200;
our $PART2_CYCLES = 50000000000;

# Save scores for each cycle
our @SCORES;

# Add extra pots to the either side
for my $i (1..200) {
    unshift @pots, '.';
    push @pots, '.';
}

#Print header
print "    ";
print " " x 20;
print "<";
print "-" x $#pots;
print ">";
say "";

# Print starting pots
say " 0:", join '', @pots;

my $prev = 0;
my $prev_diff = 0;

GENERATION:
for my $g (1..$CONVERGE_MIN) {
    my @new_pots = @pots;

    # Run the cycle
    for my $i (2..($#pots-2)) {
        my $k = join '', @pots[($i-2)..($i+2)];
        my $r = $rules{$k};
        $new_pots[$i] = $r;
    }
    @pots = @new_pots;

    # Get scores
    my $sum = 0;
    for (my $i = 0; $i <= $#pots; $i++) {
        $sum += $i - 200 if ($pots[$i] eq '#');
    }
    $SCORES[$g] = $sum;

    # Print cycle
    printf "%2d: ", $g;
    # print join '', @pots;
    say " Sum: $sum, Diff: ", $sum - $prev;
    last GENERATION if ($prev_diff == $sum - $prev);
    $prev_diff = $sum - $prev;
    $prev = $sum;
}

say "Part 1: $SCORES[20]";
say "Part 2 diff: $prev_diff";

my $ans = ($PART2_CYCLES - $#SCORES) * $prev_diff + $SCORES[$#SCORES];
say "Part 2: $ans";
