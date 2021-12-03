#!/usr/bin/perl

use List::Util qw(min max);
use Data::Dumper;

my @grid;
my @distances;
my $i = 1;

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

# Get sum of distances to each point
for my $y (0..$max_y){
    for my $x (0..$max_x){
        my $d = 0;
        for $point (keys %points){
            my ($px, $py) = split ',', $point;
            $d += abs($x-$px) + abs($y-$py);
        }
        $distances[$y][$x] = $d;
    }
}

# Count number of locations with distance < 10000
for my $y (0..$max_y){
    for my $x (0..$max_x){
        if($distances[$y][$x] < 10000){
            $count++;
        }
    }
}

print $count;
print "\n";

sub print_grid () {
    for my $y (0..$max_y){
        for my $x (0..$max_x){
            if($_[$y][$x] eq "") {
                print ".";
            } else {
                print $_[$y][$x];
            }
            print "\t";
        }
        print "\n";
    }
}
