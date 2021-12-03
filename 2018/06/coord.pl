#!/usr/bin/perl

use strict;
use warnings;
use v5.10;

use List::Util qw(min max);
use Data::Dumper;

my @grid;
my @distances;
my $i = 1;
my %points;
my ($max_x, $max_y);

# Populate grid
while (<>) {
    chomp;
    my ($x, $y) = split ", ";

    $grid[$y][$x]    = $i; # Populate grid
    $points{"$x,$y"} = $i; # Save point
    $i++;
}

# Determine dimensions of grid
for my $y (0..$#grid){
    $max_x = max($max_x, $#{$grid[$y]});
}
$max_y = $#grid;

# Get distance to each point
for my $y (0..$max_y){
    for my $x (0..$max_x){
        my $min_d = $max_x; # suitable starting value
        my $min_point;
        for my $point (keys %points){
            my ($px, $py) = split ',', $point;
            my $d = abs($px-$x) + abs($py-$y);
            if ($d == $min_d) {
                $min_point = ".";
            }elsif ($d < $min_d) {
                $min_d = $d;
                $min_point = "$px,$py";
            }
        }
        $distances[$y][$x] = $points{$min_point};
    }
}

# Count number of occurences
my %count;
for my $y (0..$max_y){
    for my $x (0..$max_x){
        $count{$distances[$y][$x]}++;
    }
}

# print Dumper \%count;
# Eliminate infinite areas from column 1
for my $y (0..$max_y){
    my $key = $distances[$y][0];
    delete $count{$key};
}
# Eliminate infinite areas from last column
for my $y (0..$max_y){
    my $key = $distances[$y][$max_x];
    delete $count{$key};
}
# Eliminate infinite areas from row 1
for my $x (0..$max_x){
    my $key = $distances[0][$x];
    delete $count{$key};
}
# Eliminate infinite areas from last row
for my $x (0..$max_x){
    my $key = $distances[$max_y][$x];
    delete $count{$key};
}

print max values %count;
print "\n";

sub print_grid () {
    for my $y (0..$max_y){
        for my $x (0..$max_x){
            if($_[$y][$x] eq "") {
                print ".";
            } else {
                print $_[$y][$x];
            }
        }
        print "\n";
    }
}
