#!/usr/bin/perl

use strict;
use warnings;
use v5.10;

our $SERIAL_NO = <>;
our $GRID_SIZE = 300;

sub get_power_lvl {
    my $sn = shift;
    my $x = shift;
    my $y = shift;

    my $rack_id = $x + 10;
    my $power = $rack_id * $y;
    $power += $sn;
    $power *= $rack_id;
    $power = substr $power, -3, 1;
    $power -= 5;

    return $power;
}

my $max_pwr = -1000;
my $max_x;
my $max_y;
my $max_size;
my @tmp_data;

for my $size (1..$GRID_SIZE) {
    @tmp_data = calc_power_region ($GRID_SIZE, $size);
    if ($tmp_data[0] > $max_pwr) {
        $max_pwr = $tmp_data[0];
        $max_x   = $tmp_data[1];
        $max_y   = $tmp_data[2];
        $max_size = $tmp_data[3];
    }
}

say "Power: $max_pwr, X = $max_x, Y = $max_y, Size = $max_size";

sub calc_power_region {
    my $grid_size = shift;
    my $size = shift;

    my $max_pwr = -100000;
    my $pwr;
    my $max_x;
    my $max_y;
    for my $x (1..$grid_size - $size + 1) {
        for my $y (1..$grid_size - $size + 1) {
            my $pwr = 0;
            for my $i ($x..($x + $size - 1)) {
                for my $j ($y..($y + $size - 1)) {
                    $pwr += get_power_lvl ($SERIAL_NO, $i, $j);
                }
            }
            if ($pwr > $max_pwr) {
                $max_pwr = $pwr;
                $max_x = $x;
                $max_y = $y;
            }
        }
    }

    return ($max_pwr, $max_x, $max_y, $size);
}

